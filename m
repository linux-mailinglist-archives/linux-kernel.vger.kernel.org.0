Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6087712971E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 15:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfLWOTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 09:19:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:18205 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbfLWOR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="249500512"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2019 06:17:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C3B90AA4; Mon, 23 Dec 2019 16:17:17 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/37] platform/x86: intel_scu_ipc: Reformat kernel-doc comments of exported functions
Date:   Mon, 23 Dec 2019 17:16:52 +0300
Message-Id: <20191223141716.13727-14-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Format kernel-doc comments of the exported functions to follow the
typical format that does not have tab indentation. Also capitalize
parameter descriptions and add a missing period.

No functional changes intended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 112 +++++++++++++--------------
 1 file changed, 55 insertions(+), 57 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index e3f658f1b40a..b1ac381bb7dd 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -219,14 +219,14 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
 }
 
 /**
- *	intel_scu_ipc_ioread8		-	read a word via the SCU
- *	@addr: register on SCU
- *	@data: return pointer for read byte
+ * intel_scu_ipc_ioread8		-	read a word via the SCU
+ * @addr: Register on SCU
+ * @data: Return pointer for read byte
  *
- *	Read a single register. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
+ * Read a single register. Returns %0 on success or an error code. All
+ * locking between SCU accesses is handled for the caller.
  *
- *	This function may sleep.
+ * This function may sleep.
  */
 int intel_scu_ipc_ioread8(u16 addr, u8 *data)
 {
@@ -235,14 +235,14 @@ int intel_scu_ipc_ioread8(u16 addr, u8 *data)
 EXPORT_SYMBOL(intel_scu_ipc_ioread8);
 
 /**
- *	intel_scu_ipc_iowrite8		-	write a byte via the SCU
- *	@addr: register on SCU
- *	@data: byte to write
+ * intel_scu_ipc_iowrite8		-	write a byte via the SCU
+ * @addr: Register on SCU
+ * @data: Byte to write
  *
- *	Write a single register. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
+ * Write a single register. Returns %0 on success or an error code. All
+ * locking between SCU accesses is handled for the caller.
  *
- *	This function may sleep.
+ * This function may sleep.
  */
 int intel_scu_ipc_iowrite8(u16 addr, u8 data)
 {
@@ -251,17 +251,17 @@ int intel_scu_ipc_iowrite8(u16 addr, u8 data)
 EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
 
 /**
- *	intel_scu_ipc_readvv		-	read a set of registers
- *	@addr: register list
- *	@data: bytes to return
- *	@len: length of array
+ * intel_scu_ipc_readvv		-	read a set of registers
+ * @addr: Register list
+ * @data: Bytes to return
+ * @len: Length of array
  *
- *	Read registers. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
+ * Read registers. Returns %0 on success or an error code. All locking
+ * between SCU accesses is handled for the caller.
  *
- *	The largest array length permitted by the hardware is 5 items.
+ * The largest array length permitted by the hardware is 5 items.
  *
- *	This function may sleep.
+ * This function may sleep.
  */
 int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
 {
@@ -270,18 +270,17 @@ int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
 EXPORT_SYMBOL(intel_scu_ipc_readv);
 
 /**
- *	intel_scu_ipc_writev		-	write a set of registers
- *	@addr: register list
- *	@data: bytes to write
- *	@len: length of array
+ * intel_scu_ipc_writev		-	write a set of registers
+ * @addr: Register list
+ * @data: Bytes to write
+ * @len: Length of array
  *
- *	Write registers. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
+ * Write registers. Returns %0 on success or an error code. All locking
+ * between SCU accesses is handled for the caller.
  *
- *	The largest array length permitted by the hardware is 5 items.
- *
- *	This function may sleep.
+ * The largest array length permitted by the hardware is 5 items.
  *
+ * This function may sleep.
  */
 int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
 {
@@ -290,19 +289,18 @@ int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
 EXPORT_SYMBOL(intel_scu_ipc_writev);
 
 /**
- *	intel_scu_ipc_update_register	-	r/m/w a register
- *	@addr: register address
- *	@bits: bits to update
- *	@mask: mask of bits to update
+ * intel_scu_ipc_update_register	-	r/m/w a register
+ * @addr: Register address
+ * @bits: Bits to update
+ * @mask: Mask of bits to update
  *
- *	Read-modify-write power control unit register. The first data argument
- *	must be register value and second is mask value
- *	mask is a bitmap that indicates which bits to update.
- *	0 = masked. Don't modify this bit, 1 = modify this bit.
- *	returns 0 on success or an error code.
+ * Read-modify-write power control unit register. The first data argument
+ * must be register value and second is mask value mask is a bitmap that
+ * indicates which bits to update. %0 = masked. Don't modify this bit, %1 =
+ * modify this bit. returns %0 on success or an error code.
  *
- *	This function may sleep. Locking between SCU accesses is handled
- *	for the caller.
+ * This function may sleep. Locking between SCU accesses is handled
+ * for the caller.
  */
 int intel_scu_ipc_update_register(u16 addr, u8 bits, u8 mask)
 {
@@ -312,16 +310,16 @@ int intel_scu_ipc_update_register(u16 addr, u8 bits, u8 mask)
 EXPORT_SYMBOL(intel_scu_ipc_update_register);
 
 /**
- *	intel_scu_ipc_simple_command	-	send a simple command
- *	@cmd: command
- *	@sub: sub type
+ * intel_scu_ipc_simple_command	-	send a simple command
+ * @cmd: Command
+ * @sub: Sub type
  *
- *	Issue a simple command to the SCU. Do not use this interface if
- *	you must then access data as any data values may be overwritten
- *	by another SCU access by the time this function returns.
+ * Issue a simple command to the SCU. Do not use this interface if you must
+ * then access data as any data values may be overwritten by another SCU
+ * access by the time this function returns.
  *
- *	This function may sleep. Locking for SCU accesses is handled for
- *	the caller.
+ * This function may sleep. Locking for SCU accesses is handled for the
+ * caller.
  */
 int intel_scu_ipc_simple_command(int cmd, int sub)
 {
@@ -341,16 +339,16 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
 EXPORT_SYMBOL(intel_scu_ipc_simple_command);
 
 /**
- *	intel_scu_ipc_command	-	command with data
- *	@cmd: command
- *	@sub: sub type
- *	@in: input data
- *	@inlen: input length in dwords
- *	@out: output data
- *	@outlein: output length in dwords
+ * intel_scu_ipc_command	-	command with data
+ * @cmd: Command
+ * @sub: Sub type
+ * @in: Input data
+ * @inlen: Input length in dwords
+ * @out: Output data
+ * @outlen: Output length in dwords
  *
- *	Issue a command to the SCU which involves data transfers. Do the
- *	data copies under the lock but leave it for the caller to interpret
+ * Issue a command to the SCU which involves data transfers. Do the
+ * data copies under the lock but leave it for the caller to interpret.
  */
 int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 			  u32 *out, int outlen)
-- 
2.24.0

