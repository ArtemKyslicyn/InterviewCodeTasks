//: [Previous](@previous)

import Foundation
import Darwin

var str = "Hello, playground"

let servicePortNumber = "3333"
let applicationInDebugMode = true

/// Returns the (host, service) tuple for a given sockaddr

func sockaddrDescription(addr: UnsafePointer<sockaddr>) -> (String?, String?) {
  
  var host : String?
  var service : String?
  
  var hostBuffer = [CChar](repeating: 0, count: Int(NI_MAXHOST))
  var serviceBuffer = [CChar](repeating: 0, count: Int(NI_MAXSERV))
  
  if getnameinfo(
    addr,
    socklen_t(addr.pointee.sa_len),
    &hostBuffer,
    socklen_t(hostBuffer.count),
    &serviceBuffer,
    socklen_t(serviceBuffer.count),
    NI_NUMERICHOST | NI_NUMERICSERV)
    
    == 0 {
    
    host = String(cString: hostBuffer)
    service = String(cString: serviceBuffer)
  }
  return (host, service)
  
}


var status: Int32 = 0


// ==================================================================
// Retrieve the information necessary to create the socket descriptor
// ==================================================================

// Protocol configuration, used to retrieve the data needed to create the socket descriptor

var hints = addrinfo(
  ai_flags: AI_PASSIVE,       // Assign the address of the local host to the socket structures
  ai_family: AF_UNSPEC,       // Either IPv4 or IPv6
  ai_socktype: SOCK_STREAM,   // TCP
  ai_protocol: 0,
  ai_addrlen: 0,
  ai_canonname: nil,
  ai_addr: nil,
  ai_next: nil)


// For the information needed to create a socket (result from the getaddrinfo)

var servinfo: UnsafeMutablePointer<addrinfo>? = nil


// Get the info we need to create our socket descriptor

status = getaddrinfo(
  nil,                        // Any interface
  servicePortNumber,          // The port on which will be listenend
  &hints,                     // Protocol configuration as per above
  &servinfo)                  // The created information


// Cop out if there is an error

if status != 0 {
  var strError: String
  if status == EAI_SYSTEM {
    strError = String(validatingUTF8: strerror(errno)) ?? "Unknown error code"
  } else {
    strError = String(validatingUTF8: gai_strerror(status)) ?? "Unknown error code"
  }
  print(strError)
  
} else {
  
  // Print a list of the found IP addresses
  
  if applicationInDebugMode {
    var info = servinfo
    while info != nil {
      let (clientIp, service) = sockaddrDescription(addr: info!.pointee.ai_addr)
      let message = "HostIp: " + (clientIp ?? "?") + " at port: " + (service ?? "?")
      print(message)
      info = info!.pointee.ai_next
    }
  }
}


// ============================
// Create the socket descriptor
// ============================

let socketDescriptor = socket(
  servinfo!.pointee.ai_family,      // Use the servinfo created earlier, this makes it IPv4/IPv6 independant
  servinfo!.pointee.ai_socktype,    // Use the servinfo created earlier, this makes it IPv4/IPv6 independant
  servinfo!.pointee.ai_protocol)    // Use the servinfo created earlier, this makes it IPv4/IPv6 independant

print("Socket value: \(socketDescriptor)")


// Cop out if there is an error

if socketDescriptor == -1 {
  let strError = String(utf8String: strerror(errno)) ?? "Unknown error code"
  let message = "Socket creation error \(errno) (\(strError))"
  freeaddrinfo(servinfo)
  print(message)
  
}


// ========================================================================
// Set the socket options (specifically: prevent the "socket in use" error)
// ========================================================================

var optval: Int = 1; // Use 1 to enable the option, 0 to disable

status = setsockopt(
  socketDescriptor,               // The socket descriptor of the socket on which the option will be set
  SOL_SOCKET,                     // Type of socket options
  SO_REUSEADDR,                   // The socket option id
  &optval,                        // The socket option value
  socklen_t(MemoryLayout<Int>.size))    // The size of the socket option value

if status == -1 {
  let strError = String(utf8String: strerror(errno)) ?? "Unknown error code"
  let message = "Setsockopt error \(errno) (\(strError))"
  freeaddrinfo(servinfo)
  close(socketDescriptor)         // Ignore possible errors
  print(message)
  //return
}
let maxNumberOfConnectionsBeforeAccept: Int32 = 20

// ====================================
// Bind the socket descriptor to a port
// ====================================

status = bind(
socketDescriptor,               // The socket descriptor of the socket to bind
servinfo!.pointee.ai_addr,        // Use the servinfo created earlier, this makes it IPv4/IPv6 independant
servinfo!.pointee.ai_addrlen)     // Use the servinfo created earlier, this makes it IPv4/IPv6 independant

print("Status from binding: \(status)")


// Cop out if there is an error

if status != 0 {
  let strError = String(utf8String: strerror(errno)) ?? "Unknown error code"
  let message = "Binding error \(errno) (\(strError))"
  freeaddrinfo(servinfo)
  close(socketDescriptor)         // Ignore possible errors
  print (message)
 // return
}


// ===============================
// Don't need the servinfo anymore
// ===============================

freeaddrinfo(servinfo)


// ========================================
// Start listening for incoming connections
// ========================================

status = listen(
  socketDescriptor,                     // The socket on which to listen
  maxNumberOfConnectionsBeforeAccept)   // The number of connections that will be allowed before they are accepted

print("Status from listen: " + status.description)


// Cop out if there are any errors

if status != 0 {
  let strError = String(utf8String: strerror(errno)) ?? "Unknown error code"
  let message = "Listen error \(errno) (\(strError))"
  print(message)
  close(socketDescriptor)         // Ignore possible errors
  //return
  
}

// =================================================
// Initialize the port on which we will be listening
// =================================================

let httpSocketDescriptor = socketDescriptor
//
if httpSocketDescriptor == nil {

} // Log entries should have been made

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
//// ===========================================================================
//// Keep on accepting connection requests until a fatal error or a stop request
//// ===========================================================================
//
//stopAcceptThread = false
//
//let acceptQueue: DispatchQueue = DispatchQueue(
//  label: "Accept queue",
//  attributes: [.serial, .qosUserInteractive])
//
//acceptQueue.async() { acceptConnectionRequests(httpSocketDescriptor!) }

//...{...
  
  // Incoming connections will be executed in this queue (in parallel)
  

let connectionQueue = DispatchQueue(label: "ConnectionQueue", qos: .userInteractive, attributes: .concurrent)
  
  
  // ========================
  // Start the "endless" loop
  // ========================
  
  ACCEPT_LOOP: while true {
    
    
    // =======================================
    // Wait for an incoming connection request
    // =======================================
    
    var connectedAddrInfo = sockaddr(sa_len: 0, sa_family: 0, sa_data: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
    var connectedAddrInfoLength = socklen_t(MemoryLayout<sockaddr>.size)
    
    let requestDescriptor = accept(socketDescriptor, &connectedAddrInfo, &connectedAddrInfoLength)
    
    if requestDescriptor == -1 {
      let strerr = String(utf8String: strerror(errno)) ?? "Unknown error code"
      let message = "Accept error \(errno) " + strerr
      print(message)
      // #FEATURE# Add code to cop out if errors occur continuously
      continue
    }
    
    
    let (ipAddress, servicePort) = sockaddrDescription(addr: &connectedAddrInfo)
    
    let message = "Accepted connection from: " + (ipAddress ?? "nil") + ", from port:" + (servicePort ?? "nil")
    print(message)
    
    
    // ==========================================================================
    // Request processing of the connection request in a different dispatch queue
    // ==========================================================================
    
    connectionQueue.async() {
      
     //receiveAndDispatch(socket: requestDescriptor)
    }


    func receiveAndDispatch(socket: Int32) {
  
  
    }
}


//: [Next](@next)
