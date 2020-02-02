Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0862614FB01
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 01:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBBAB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 19:01:26 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:44836 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgBBAB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 19:01:26 -0500
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1iy2hR-0005Rx-Qb; Sun, 02 Feb 2020 01:01:17 +0100
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7] zswap: allow setting default status, compressor and allocator in Kconfig
Date:   Sun,  2 Feb 2020 01:01:12 +0100
Message-Id: <20200202000112.456103-1-mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed cache for swap pages (zswap) currently needs from 1 to 3
extra kernel command line parameters in order to make it work: it has to be
enabled by adding a "zswap.enabled=1" command line parameter and if one
wants a different compressor or pool allocator than the default lzo / zbud
combination then these choices also need to be specified on the kernel
command line in additional parameters.

Using a different compressor and allocator for zswap is actually pretty
common as guides often recommend using the lz4 / z3fold pair instead of
the default one.
In such case it is also necessary to remember to enable the appropriate
compression algorithm and pool allocator in the kernel config manually.

Let's avoid the need for adding these kernel command line parameters and
automatically pull in the dependencies for the selected compressor
algorithm and pool allocator by adding an appropriate default switches to
Kconfig.

The default values for these options match what the code was using
previously as its defaults.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
---

Changes from v1:
Rename CONFIG_ZSWAP_DEFAULT_COMP_* to CONFIG_ZSWAP_COMPRESSOR_DEFAULT_*
and CONFIG_ZSWAP_DEFAULT_ZPOOL_* to CONFIG_ZSWAP_ZPOOL_DEFAULT_* while
dropping the "_NAME" suffix from the final string option in both cases.

Changes from v2:
Add zsmalloc as a pool allocator choice, add a link to a page with
benchmarks of various compression algorithms to the compression
algorithm prompt option.

Changes from v3:
Update the zswap doc in Documentation, too.

Changes from v4:
Use IS_ENABLED() macro to initialize the zswap_enabled variable,
make CONFIG_ZSWAP_COMPRESSOR_DEFAULT and CONFIG_ZSWAP_ZPOOL_DEFAULT
depend on CONFIG_ZSWAP so they don't show in .config when zswap is
deselected in Kconfig.

Changes from v5:
Add Vitaly's "Reviewed-by" tag.

Changes from v6:
Rebase onto current torvalds/master, add more people from
get_maintainer.pl to the CC list.

 Documentation/vm/zswap.rst |  20 ++++---
 mm/Kconfig                 | 118 ++++++++++++++++++++++++++++++++++++-
 mm/zswap.c                 |  24 ++++----
 3 files changed, 141 insertions(+), 21 deletions(-)

diff --git a/Documentation/vm/zswap.rst b/Documentation/vm/zswap.rst
index 61f6185188cd..f8c6a79d7c70 100644
--- a/Documentation/vm/zswap.rst
+++ b/Documentation/vm/zswap.rst
@@ -35,9 +35,11 @@ Zswap evicts pages from compressed cache on an LRU basis to the backing swap
 device when the compressed pool reaches its size limit.  This requirement had
 been identified in prior community discussions.
 
-Zswap is disabled by default but can be enabled at boot time by setting
-the ``enabled`` attribute to 1 at boot time. ie: ``zswap.enabled=1``.  Zswap
-can also be enabled and disabled at runtime using the sysfs interface.
+Whether Zswap is enabled at the boot time depends on whether
+the ``CONFIG_ZSWAP_DEFAULT_ON`` Kconfig option is enabled or not.
+This setting can then be overridden by providing the kernel command line
+``zswap.enabled=`` option, for example ``zswap.enabled=0``.
+Zswap can also be enabled and disabled at runtime using the sysfs interface.
 An example command to enable zswap at runtime, assuming sysfs is mounted
 at ``/sys``, is::
 
@@ -64,9 +66,10 @@ allocation in zpool is not directly accessible by address.  Rather, a handle is
 returned by the allocation routine and that handle must be mapped before being
 accessed.  The compressed memory pool grows on demand and shrinks as compressed
 pages are freed.  The pool is not preallocated.  By default, a zpool
-of type zbud is created, but it can be selected at boot time by
-setting the ``zpool`` attribute, e.g. ``zswap.zpool=zbud``. It can
-also be changed at runtime using the sysfs ``zpool`` attribute, e.g.::
+of type selected in ``CONFIG_ZSWAP_ZPOOL_DEFAULT`` Kconfig option is created,
+but it can be overridden at boot time by setting the ``zpool`` attribute,
+e.g. ``zswap.zpool=zbud``. It can also be changed at runtime using the sysfs
+``zpool`` attribute, e.g.::
 
 	echo zbud > /sys/module/zswap/parameters/zpool
 
@@ -97,8 +100,9 @@ controlled policy:
 * max_pool_percent - The maximum percentage of memory that the compressed
   pool can occupy.
 
-The default compressor is lzo, but it can be selected at boot time by
-setting the ``compressor`` attribute, e.g. ``zswap.compressor=lzo``.
+The default compressor is selected in ``CONFIG_ZSWAP_COMPRESSOR_DEFAULT``
+Kconfig option, but it can be overridden at boot time by setting the
+``compressor`` attribute, e.g. ``zswap.compressor=lzo``.
 It can also be changed at runtime using the sysfs "compressor"
 attribute, e.g.::
 
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..1209240bfbe0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -526,7 +526,6 @@ config MEM_SOFT_DIRTY
 config ZSWAP
 	bool "Compressed cache for swap pages (EXPERIMENTAL)"
 	depends on FRONTSWAP && CRYPTO=y
-	select CRYPTO_LZO
 	select ZPOOL
 	help
 	  A lightweight compressed cache for swap pages.  It takes
@@ -542,6 +541,123 @@ config ZSWAP
 	  they have not be fully explored on the large set of potential
 	  configurations and workloads that exist.
 
+choice
+	prompt "Compressed cache for swap pages default compressor"
+	depends on ZSWAP
+	default ZSWAP_COMPRESSOR_DEFAULT_LZO
+	help
+	  Selects the default compression algorithm for the compressed cache
+	  for swap pages.
+
+	  For an overview what kind of performance can be expected from
+	  a particular compression algorithm please refer to the benchmarks
+	  available at the following LWN page:
+	  https://lwn.net/Articles/751795/
+
+	  If in doubt, select 'LZO'.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.compressor=' option.
+
+config ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+	bool "Deflate"
+	select CRYPTO_DEFLATE
+	help
+	  Use the Deflate algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZO
+	bool "LZO"
+	select CRYPTO_LZO
+	help
+	  Use the LZO algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_842
+	bool "842"
+	select CRYPTO_842
+	help
+	  Use the 842 algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZ4
+	bool "LZ4"
+	select CRYPTO_LZ4
+	help
+	  Use the LZ4 algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
+	bool "LZ4HC"
+	select CRYPTO_LZ4HC
+	help
+	  Use the LZ4HC algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_ZSTD
+	bool "zstd"
+	select CRYPTO_ZSTD
+	help
+	  Use the zstd algorithm as the default compression algorithm.
+endchoice
+
+config ZSWAP_COMPRESSOR_DEFAULT
+       string
+       depends on ZSWAP
+       default "deflate" if ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+       default "lzo" if ZSWAP_COMPRESSOR_DEFAULT_LZO
+       default "842" if ZSWAP_COMPRESSOR_DEFAULT_842
+       default "lz4" if ZSWAP_COMPRESSOR_DEFAULT_LZ4
+       default "lz4hc" if ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
+       default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
+       default ""
+
+choice
+	prompt "Compressed cache for swap pages default allocator"
+	depends on ZSWAP
+	default ZSWAP_ZPOOL_DEFAULT_ZBUD
+	help
+	  Selects the default allocator for the compressed cache for
+	  swap pages.
+	  The default is 'zbud' for compatibility, however please do
+	  read the description of each of the allocators below before
+	  making a right choice.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.zpool=' option.
+
+config ZSWAP_ZPOOL_DEFAULT_ZBUD
+	bool "zbud"
+	select ZBUD
+	help
+	  Use the zbud allocator as the default allocator.
+
+config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+	bool "z3fold"
+	select Z3FOLD
+	help
+	  Use the z3fold allocator as the default allocator.
+
+config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
+	bool "zsmalloc"
+	select ZSMALLOC
+	help
+	  Use the zsmalloc allocator as the default allocator.
+endchoice
+
+config ZSWAP_ZPOOL_DEFAULT
+       string
+       depends on ZSWAP
+       default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
+       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
+       default ""
+
+config ZSWAP_DEFAULT_ON
+	bool "Enable the compressed cache for swap pages by default"
+	depends on ZSWAP
+	help
+	  If selected, the compressed cache for swap pages will be enabled
+	  at boot, otherwise it will be disabled.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.enabled=' option.
+
 config ZPOOL
 	tristate "Common API for compressed memory storage"
 	help
diff --git a/mm/zswap.c b/mm/zswap.c
index 55094e63b72d..fbb782924ccc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -77,8 +77,8 @@ static bool zswap_pool_reached_full;
 
 #define ZSWAP_PARAM_UNSET ""
 
-/* Enable/disable zswap (disabled by default) */
-static bool zswap_enabled;
+/* Enable/disable zswap */
+static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
 static int zswap_enabled_param_set(const char *,
 				   const struct kernel_param *);
 static struct kernel_param_ops zswap_enabled_param_ops = {
@@ -88,8 +88,7 @@ static struct kernel_param_ops zswap_enabled_param_ops = {
 module_param_cb(enabled, &zswap_enabled_param_ops, &zswap_enabled, 0644);
 
 /* Crypto compressor to use */
-#define ZSWAP_COMPRESSOR_DEFAULT "lzo"
-static char *zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
+static char *zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
 static int zswap_compressor_param_set(const char *,
 				      const struct kernel_param *);
 static struct kernel_param_ops zswap_compressor_param_ops = {
@@ -101,8 +100,7 @@ module_param_cb(compressor, &zswap_compressor_param_ops,
 		&zswap_compressor, 0644);
 
 /* Compressed storage zpool to use */
-#define ZSWAP_ZPOOL_DEFAULT "zbud"
-static char *zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
+static char *zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
 static int zswap_zpool_param_set(const char *, const struct kernel_param *);
 static struct kernel_param_ops zswap_zpool_param_ops = {
 	.set =		zswap_zpool_param_set,
@@ -599,11 +597,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
 	bool has_comp, has_zpool;
 
 	has_comp = crypto_has_comp(zswap_compressor, 0, 0);
-	if (!has_comp && strcmp(zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT)) {
+	if (!has_comp && strcmp(zswap_compressor,
+				CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
 		pr_err("compressor %s not available, using default %s\n",
-		       zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT);
+		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
 		param_free_charp(&zswap_compressor);
-		zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
+		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
 		has_comp = crypto_has_comp(zswap_compressor, 0, 0);
 	}
 	if (!has_comp) {
@@ -614,11 +613,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
 	}
 
 	has_zpool = zpool_has_pool(zswap_zpool_type);
-	if (!has_zpool && strcmp(zswap_zpool_type, ZSWAP_ZPOOL_DEFAULT)) {
+	if (!has_zpool && strcmp(zswap_zpool_type,
+				 CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
 		pr_err("zpool %s not available, using default %s\n",
-		       zswap_zpool_type, ZSWAP_ZPOOL_DEFAULT);
+		       zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
 		param_free_charp(&zswap_zpool_type);
-		zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
+		zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
 		has_zpool = zpool_has_pool(zswap_zpool_type);
 	}
 	if (!has_zpool) {
