Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2612858B37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 21:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfF0Tzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 15:55:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23412 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0Tz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561665325; x=1593201325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R4jfjZMxUWSzFwisiuVjBFLXxDAnXEO77dQqxAyI1wE=;
  b=ApRrQeT5vkHaNV85HqQPY2zXfXYziGPf+zX8Gzv1Wn3JuIFpEzkpzDyt
   KLKDYN6bXLIJeIhVduXnmpPuBo8lOshu/9oSoWSUC/1UX0+Qwe1QlAXFu
   KDL255bFDnLn0Cx4p4pGueZiVPH0VusFbg+riW/K3YJdczEhz4qaR8T7y
   7dhJze9I/JHHHgmrTjdzILbuJvXkksHbNvIIvekMFdwq3NZ98/8i2Iu1I
   PCkySWk0TNP3rf2veFwD0CZ/jfJoCl+1gt1wXVX4egEG9PxC1Im/j53jq
   A7dvTiaSAXPYxcnpzAcSPXBcUZemDDKLFP/74lAQ/SS44PU+mZv4OsGsJ
   g==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="112927434"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 03:55:24 +0800
IronPort-SDR: c3iIjetTeO8V+oB6XyRueLgF5WP/2xbKuT3StzNHVinKFVOFmt1MtwDjZaOHuLNAwHvin8fGP8
 b62Vqaf+8v1NVijJpf5MA1oCueYFpno6VX3c778RA5zzu07gLvc8R1+BO9o2RgLM2iUp5wMxIe
 zKXkG3fOt9qVbqaXvQqVIqMmaZVEOWGEgr3i46mE+lgVBdEuYbKjND7O4wngmks7aGPzBP/Y2C
 Orfb6P8CA56W+Vj3eXpQGPPBLYnyy+4OVp2lScYowsUS4MMu8tiqSALJ8zYphYiwlOMpVcblr5
 wPb5AUsA7Vi+6FBu3lW7foPh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 27 Jun 2019 12:54:38 -0700
IronPort-SDR: zrZX6RAbOPoSs5QMZIqfjIVfLPRAfo+phS5jzwXRWAwg0bCtmLWKKOjf5WM/+ysKs88/8jV8D8
 GgQ3+6aktI6mnATTDgLps2zNlvwrwikyl1o+hnJ9W+fsGZ8kFR5LOtP7IAZsespf9vIuLZjiYa
 WFcPoI5TYkJVnyLYWLB8aMxqzD0vx1PP72A8kIWdiQUPlJGZpouXJXliay5wvI/nDfLD2olu4+
 NeVibRmlcwz/JPb2fSEFN+IVh2bBKk6khcBif0vGeMBP6FlKZDMYZtGeJHolZ65m6FEoLDE2Ke
 Vq0=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 12:55:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v8 1/7] Documentation: DT: arm: add support for sockets defining package boundaries
Date:   Thu, 27 Jun 2019 12:52:56 -0700
Message-Id: <20190627195302.28300-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627195302.28300-1-atish.patra@wdc.com>
References: <20190627195302.28300-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

The current ARM DT topology description provides the operating system
with a topological view of the system that is based on leaf nodes
representing either cores or threads (in an SMT system) and a
hierarchical set of cluster nodes that creates a hierarchical topology
view of how those cores and threads are grouped.

However this hierarchical representation of clusters does not allow to
describe what topology level actually represents the physical package or
the socket boundary, which is a key piece of information to be used by
an operating system to optimize resource allocation and scheduling.

Lets add a new "socket" node type in the cpu-map node to describe the
same.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/topology.txt      | 172 ++++++++++--------
 1 file changed, 99 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
index b0d80c0fb265..3b8febb46dad 100644
--- a/Documentation/devicetree/bindings/arm/topology.txt
+++ b/Documentation/devicetree/bindings/arm/topology.txt
@@ -9,6 +9,7 @@ ARM topology binding description
 In an ARM system, the hierarchy of CPUs is defined through three entities that
 are used to describe the layout of physical CPUs in the system:
 
+- socket
 - cluster
 - core
 - thread
@@ -63,21 +64,23 @@ nodes are listed.
 
 	The cpu-map node's child nodes can be:
 
-	- one or more cluster nodes
+	- one or more cluster nodes or
+	- one or more socket nodes in a multi-socket system
 
 	Any other configuration is considered invalid.
 
-The cpu-map node can only contain three types of child nodes:
+The cpu-map node can only contain 4 types of child nodes:
 
+- socket node
 - cluster node
 - core node
 - thread node
 
 whose bindings are described in paragraph 3.
 
-The nodes describing the CPU topology (cluster/core/thread) can only
-be defined within the cpu-map node and every core/thread in the system
-must be defined within the topology.  Any other configuration is
+The nodes describing the CPU topology (socket/cluster/core/thread) can
+only be defined within the cpu-map node and every core/thread in the
+system must be defined within the topology.  Any other configuration is
 invalid and therefore must be ignored.
 
 ===========================================
@@ -85,26 +88,44 @@ invalid and therefore must be ignored.
 ===========================================
 
 cpu-map child nodes must follow a naming convention where the node name
-must be "clusterN", "coreN", "threadN" depending on the node type (ie
-cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes which
-are siblings within a single common parent node must be given a unique and
+must be "socketN", "clusterN", "coreN", "threadN" depending on the node type
+(ie socket/cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes
+which are siblings within a single common parent node must be given a unique and
 sequential N value, starting from 0).
 cpu-map child nodes which do not share a common parent node can have the same
 name (ie same number N as other cpu-map child nodes at different device tree
 levels) since name uniqueness will be guaranteed by the device tree hierarchy.
 
 ===========================================
-3 - cluster/core/thread node bindings
+3 - socket/cluster/core/thread node bindings
 ===========================================
 
-Bindings for cluster/cpu/thread nodes are defined as follows:
+Bindings for socket/cluster/cpu/thread nodes are defined as follows:
+
+- socket node
+
+	 Description: must be declared within a cpu-map node, one node
+		      per physical socket in the system. A system can
+		      contain single or multiple physical socket.
+		      The association of sockets and NUMA nodes is beyond
+		      the scope of this bindings, please refer [2] for
+		      NUMA bindings.
+
+	This node is optional for a single socket system.
+
+	The socket node name must be "socketN" as described in 2.1 above.
+	A socket node can not be a leaf node.
+
+	A socket node's child nodes must be one or more cluster nodes.
+
+	Any other configuration is considered invalid.
 
 - cluster node
 
 	 Description: must be declared within a cpu-map node, one node
 		      per cluster. A system can contain several layers of
-		      clustering and cluster nodes can be contained in parent
-		      cluster nodes.
+		      clustering within a single physical socket and cluster
+		      nodes can be contained in parent cluster nodes.
 
 	The cluster node name must be "clusterN" as described in 2.1 above.
 	A cluster node can not be a leaf node.
@@ -164,90 +185,93 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
 4 - Example dts
 ===========================================
 
-Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
+Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters in a single
+physical socket):
 
 cpus {
 	#size-cells = <0>;
 	#address-cells = <2>;
 
 	cpu-map {
-		cluster0 {
+		socket0 {
 			cluster0 {
-				core0 {
-					thread0 {
-						cpu = <&CPU0>;
-					};
-					thread1 {
-						cpu = <&CPU1>;
+				cluster0 {
+					core0 {
+						thread0 {
+							cpu = <&CPU0>;
+						};
+						thread1 {
+							cpu = <&CPU1>;
+						};
 					};
-				};
 
-				core1 {
-					thread0 {
-						cpu = <&CPU2>;
-					};
-					thread1 {
-						cpu = <&CPU3>;
+					core1 {
+						thread0 {
+							cpu = <&CPU2>;
+						};
+						thread1 {
+							cpu = <&CPU3>;
+						};
 					};
 				};
-			};
 
-			cluster1 {
-				core0 {
-					thread0 {
-						cpu = <&CPU4>;
-					};
-					thread1 {
-						cpu = <&CPU5>;
+				cluster1 {
+					core0 {
+						thread0 {
+							cpu = <&CPU4>;
+						};
+						thread1 {
+							cpu = <&CPU5>;
+						};
 					};
-				};
-
-				core1 {
-					thread0 {
-						cpu = <&CPU6>;
-					};
-					thread1 {
-						cpu = <&CPU7>;
-					};
-				};
-			};
-		};
 
-		cluster1 {
-			cluster0 {
-				core0 {
-					thread0 {
-						cpu = <&CPU8>;
-					};
-					thread1 {
-						cpu = <&CPU9>;
-					};
-				};
-				core1 {
-					thread0 {
-						cpu = <&CPU10>;
-					};
-					thread1 {
-						cpu = <&CPU11>;
+					core1 {
+						thread0 {
+							cpu = <&CPU6>;
+						};
+						thread1 {
+							cpu = <&CPU7>;
+						};
 					};
 				};
 			};
 
 			cluster1 {
-				core0 {
-					thread0 {
-						cpu = <&CPU12>;
+				cluster0 {
+					core0 {
+						thread0 {
+							cpu = <&CPU8>;
+						};
+						thread1 {
+							cpu = <&CPU9>;
+						};
 					};
-					thread1 {
-						cpu = <&CPU13>;
+					core1 {
+						thread0 {
+							cpu = <&CPU10>;
+						};
+						thread1 {
+							cpu = <&CPU11>;
+						};
 					};
 				};
-				core1 {
-					thread0 {
-						cpu = <&CPU14>;
+
+				cluster1 {
+					core0 {
+						thread0 {
+							cpu = <&CPU12>;
+						};
+						thread1 {
+							cpu = <&CPU13>;
+						};
 					};
-					thread1 {
-						cpu = <&CPU15>;
+					core1 {
+						thread0 {
+							cpu = <&CPU14>;
+						};
+						thread1 {
+							cpu = <&CPU15>;
+						};
 					};
 				};
 			};
@@ -473,3 +497,5 @@ cpus {
 ===============================================================================
 [1] ARM Linux kernel documentation
     Documentation/devicetree/bindings/arm/cpus.yaml
+[2] Devicetree NUMA binding description
+    Documentation/devicetree/bindings/numa.txt
-- 
2.21.0

