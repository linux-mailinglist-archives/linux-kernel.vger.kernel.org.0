Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB9312AF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 23:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLZWkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 17:40:40 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43013 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZWkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:40:39 -0500
Received: by mail-il1-f195.google.com with SMTP id v69so21097508ili.10;
        Thu, 26 Dec 2019 14:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScU1MX2NEah2LBpw4ejnPwfmUzUDKflMUjp7TE9pgIw=;
        b=YYQ2pFYx6hFWmgYeZ5GCPFepFnUJQFFnMxxcjJ2Qj53vRBiBZSMH07nd8GD6PUc5fh
         uoJU4qBMXkY7JuklLUZdkMY7aUNsZnVsxV/V66yCG7fEYuzd1+bIYPULA9pWf2hhSX/B
         5HKuCOUO1fiF9JEI0D6r9AOEg7bcLY1lPsMN8fDlKFKCAmRT7P16k8XccIZhzjI4kccd
         E6zw9TfqzS6KkliKldDJYh04CB0nmQWCMDk9LWV8hHncS2wBJj5XBZTDo2FVlBcWOJtY
         Reh2huyUYvoUS+JRD5qxuQZTKd1Kq2wYu+Tfl1kLFYHSgc2lPsU0ovCxE3m6fZio3HCI
         YpyA==
X-Gm-Message-State: APjAAAVG/iIJ368eVXT6MSdxtlbqhv503z0AcucQ8WsARPMaU+WtQwVm
        Im78oBsLI7YW8TSqJ71pbws/1EM=
X-Google-Smtp-Source: APXvYqycmrJj1MD0bIoTy+e7Z6PGmi5l/Ou9AJE61k1DKonTyrenMukBPHUyYdLHq7GjQV49Y77IPA==
X-Received: by 2002:a92:91c7:: with SMTP id e68mr42884312ill.161.1577400038309;
        Thu, 26 Dec 2019 14:40:38 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.250])
        by smtp.googlemail.com with ESMTPSA id t19sm6452533ioc.38.2019.12.26.14.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:40:37 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH] scripts/dtc: Update to upstream version v1.5.1-22-gc40aeb60b47a
Date:   Thu, 26 Dec 2019 15:40:36 -0700
Message-Id: <20191226224036.21691-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the following commits from upstream:

c40aeb60b47a travis.yml: Run tests on the non-x86 builders, too
9f86aff444f4 Add .cirrus.yml for FreeBSD build
34c82275bae6 Avoid gnu_printf attribute when using Clang
743000931bc9 tests: default to 'cc' if CC not set
adcd676491cc Add test-case for trailing zero
d9c55f855b65 Remove trailing zero from the overlay path
7a22132c79ec pylibfdt: Adjust for deprecated test methods
dbe80d577ee2 tests: add extension to sed -i for GNU/BSD sed compatibility
af57d440d887 libfdt: Correct prototype for fdt_ro_probe_()
6ce585ac153b Use correct inttypes.h format specifier
715028622547 support byacc in addition to bison
fdf3f6d897ab pylibfdt: Correct the type for fdt_property_stub()
430419c28100 tests: fix some python warnings
588a29ff2e4e util: use gnu_printf format attribute
bc876708ab1d fstree: replace lstat with stat
4c3c4ccb9916 dumptrees: pass outputdir as first argument
aa522da9fff6 tests: allow out-of-tree test run
0d0d0fa51b1f fdtoverlay: Return non-zero exit code if overlays can't be applied
4605eb047b38 Add .editorconfig
18d7b2f4ee45 yamltree: Ensure consistent bracketing of properties with phandles
67f790c1adcc libfdt.h: add explicit cast from void* to uint8_t* in fdt(32|64)_st
b111122ea5eb pylibfdt: use python3 shebang
60e0db3d65a1 Ignore phandle properties in /aliases
95ce19c14064 README: update for Python 3
5345db19f615 livetree: simplify condition in get_node_by_path
b8d6eca78210 libfdt: Allow #size-cells of 0
184f51099471 Makefile: Add EXTRA_CFLAGS variable
812b1956a076 libfdt: Tweak data handling to satisfy Coverity
5c715a44776a fdtoverlay: Ignore symbols in overlays which don't apply to the target tree
b99353474850 fdtoverlay: Allow adding labels to __overlay__ nodes in overlays
d6de81b81b68 pylibfdt: Add support for fdt_get_alias()
1c17714dbb3a pylibfdt: Correct the FdtSw example
ad57e4574a37 tests: Add a failed test case for 'fdtoverlay' with long target path
bbe3b36f542b fdtoverlay: Rework output allocation
6c2e61f08396 fdtoverlay: Improve error messages
297f5abb362e fdtoverlay: Check for truncated overlay blobs

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/checks.c                 |  5 +++++
 scripts/dtc/dtc-parser.y             |  4 ++++
 scripts/dtc/fstree.c                 |  2 +-
 scripts/dtc/libfdt/fdt.c             |  9 +++++++--
 scripts/dtc/libfdt/fdt_addresses.c   |  8 +++++---
 scripts/dtc/libfdt/fdt_overlay.c     | 28 +++++++++++++++++++---------
 scripts/dtc/libfdt/fdt_ro.c          | 11 ++++++-----
 scripts/dtc/libfdt/libfdt.h          |  4 ++--
 scripts/dtc/libfdt/libfdt_internal.h | 12 ++++++------
 scripts/dtc/livetree.c               |  3 +--
 scripts/dtc/util.c                   |  3 ++-
 scripts/dtc/util.h                   |  4 ++++
 scripts/dtc/version_gen.h            |  2 +-
 scripts/dtc/yamltree.c               | 21 +++++++++++++++++++++
 14 files changed, 84 insertions(+), 32 deletions(-)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index d7986ee18012..756f0fa9203f 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -691,6 +691,11 @@ static void check_alias_paths(struct check *c, struct dt_info *dti,
 		return;
 
 	for_each_property(node, prop) {
+		if (streq(prop->name, "phandle")
+		    || streq(prop->name, "linux,phandle")) {
+			continue;
+		}
+
 		if (!prop->val.val || !get_node_by_path(dti->dt, prop->val.val)) {
 			FAIL_PROP(c, dti, node, prop, "aliases property is not a valid node (%s)",
 				  prop->val.val);
diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
index 2ed4dc1f07fd..40dcf4f149da 100644
--- a/scripts/dtc/dtc-parser.y
+++ b/scripts/dtc/dtc-parser.y
@@ -2,6 +2,8 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  */
+%locations
+
 %{
 #include <stdio.h>
 #include <inttypes.h>
@@ -17,6 +19,8 @@ extern void yyerror(char const *s);
 		treesource_error = true; \
 	} while (0)
 
+#define YYERROR_CALL(msg) yyerror(msg)
+
 extern struct dt_info *parser_output;
 extern bool treesource_error;
 %}
diff --git a/scripts/dtc/fstree.c b/scripts/dtc/fstree.c
index 9871689b4afb..5e59594ab301 100644
--- a/scripts/dtc/fstree.c
+++ b/scripts/dtc/fstree.c
@@ -30,7 +30,7 @@ static struct node *read_fstree(const char *dirname)
 
 		tmpname = join_path(dirname, de->d_name);
 
-		if (lstat(tmpname, &st) < 0)
+		if (stat(tmpname, &st) < 0)
 			die("stat(%s): %s\n", tmpname, strerror(errno));
 
 		if (S_ISREG(st.st_mode)) {
diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
index 179168ec63e9..d6ce7c052dc8 100644
--- a/scripts/dtc/libfdt/fdt.c
+++ b/scripts/dtc/libfdt/fdt.c
@@ -15,8 +15,10 @@
  * that the given buffer contains what appears to be a flattened
  * device tree with sane information in its header.
  */
-int fdt_ro_probe_(const void *fdt)
+int32_t fdt_ro_probe_(const void *fdt)
 {
+	uint32_t totalsize = fdt_totalsize(fdt);
+
 	if (fdt_magic(fdt) == FDT_MAGIC) {
 		/* Complete tree */
 		if (fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
@@ -31,7 +33,10 @@ int fdt_ro_probe_(const void *fdt)
 		return -FDT_ERR_BADMAGIC;
 	}
 
-	return 0;
+	if (totalsize < INT32_MAX)
+		return totalsize;
+	else
+		return -FDT_ERR_TRUNCATED;
 }
 
 static int check_off_(uint32_t hdrsize, uint32_t totalsize, uint32_t off)
diff --git a/scripts/dtc/libfdt/fdt_addresses.c b/scripts/dtc/libfdt/fdt_addresses.c
index d8ba8ec60c6c..9a82cd0ba2f9 100644
--- a/scripts/dtc/libfdt/fdt_addresses.c
+++ b/scripts/dtc/libfdt/fdt_addresses.c
@@ -14,7 +14,7 @@
 static int fdt_cells(const void *fdt, int nodeoffset, const char *name)
 {
 	const fdt32_t *c;
-	int val;
+	uint32_t val;
 	int len;
 
 	c = fdt_getprop(fdt, nodeoffset, name, &len);
@@ -25,10 +25,10 @@ static int fdt_cells(const void *fdt, int nodeoffset, const char *name)
 		return -FDT_ERR_BADNCELLS;
 
 	val = fdt32_to_cpu(*c);
-	if ((val <= 0) || (val > FDT_MAX_NCELLS))
+	if (val > FDT_MAX_NCELLS)
 		return -FDT_ERR_BADNCELLS;
 
-	return val;
+	return (int)val;
 }
 
 int fdt_address_cells(const void *fdt, int nodeoffset)
@@ -36,6 +36,8 @@ int fdt_address_cells(const void *fdt, int nodeoffset)
 	int val;
 
 	val = fdt_cells(fdt, nodeoffset, "#address-cells");
+	if (val == 0)
+		return -FDT_ERR_BADNCELLS;
 	if (val == -FDT_ERR_NOTFOUND)
 		return 2;
 	return val;
diff --git a/scripts/dtc/libfdt/fdt_overlay.c b/scripts/dtc/libfdt/fdt_overlay.c
index e97f12b1a780..b310e49a698e 100644
--- a/scripts/dtc/libfdt/fdt_overlay.c
+++ b/scripts/dtc/libfdt/fdt_overlay.c
@@ -733,26 +733,36 @@ static int overlay_symbol_update(void *fdt, void *fdto)
 		/* keep end marker to avoid strlen() */
 		e = path + path_len;
 
-		/* format: /<fragment-name>/__overlay__/<relative-subnode-path> */
-
 		if (*path != '/')
 			return -FDT_ERR_BADVALUE;
 
 		/* get fragment name first */
 		s = strchr(path + 1, '/');
-		if (!s)
-			return -FDT_ERR_BADOVERLAY;
+		if (!s) {
+			/* Symbol refers to something that won't end
+			 * up in the target tree */
+			continue;
+		}
 
 		frag_name = path + 1;
 		frag_name_len = s - path - 1;
 
 		/* verify format; safe since "s" lies in \0 terminated prop */
 		len = sizeof("/__overlay__/") - 1;
-		if ((e - s) < len || memcmp(s, "/__overlay__/", len))
-			return -FDT_ERR_BADOVERLAY;
-
-		rel_path = s + len;
-		rel_path_len = e - rel_path;
+		if ((e - s) > len && (memcmp(s, "/__overlay__/", len) == 0)) {
+			/* /<fragment-name>/__overlay__/<relative-subnode-path> */
+			rel_path = s + len;
+			rel_path_len = e - rel_path - 1;
+		} else if ((e - s) == len
+			   && (memcmp(s, "/__overlay__", len - 1) == 0)) {
+			/* /<fragment-name>/__overlay__ */
+			rel_path = "";
+			rel_path_len = 0;
+		} else {
+			/* Symbol refers to something that won't end
+			 * up in the target tree */
+			continue;
+		}
 
 		/* find the fragment index in which the symbol lies */
 		ret = fdt_subnode_offset_namelen(fdto, 0, frag_name,
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index 6fd9ec170dbe..a5c2797cde65 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -33,19 +33,20 @@ static int fdt_nodename_eq_(const void *fdt, int offset,
 
 const char *fdt_get_string(const void *fdt, int stroffset, int *lenp)
 {
+	int32_t totalsize = fdt_ro_probe_(fdt);
 	uint32_t absoffset = stroffset + fdt_off_dt_strings(fdt);
 	size_t len;
 	int err;
 	const char *s, *n;
 
-	err = fdt_ro_probe_(fdt);
-	if (err != 0)
+	err = totalsize;
+	if (totalsize < 0)
 		goto fail;
 
 	err = -FDT_ERR_BADOFFSET;
-	if (absoffset >= fdt_totalsize(fdt))
+	if (absoffset >= totalsize)
 		goto fail;
-	len = fdt_totalsize(fdt) - absoffset;
+	len = totalsize - absoffset;
 
 	if (fdt_magic(fdt) == FDT_MAGIC) {
 		if (stroffset < 0)
@@ -288,7 +289,7 @@ const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
 	const char *nameptr;
 	int err;
 
-	if (((err = fdt_ro_probe_(fdt)) != 0)
+	if (((err = fdt_ro_probe_(fdt)) < 0)
 	    || ((err = fdt_check_node_offset_(fdt, nodeoffset)) < 0))
 			goto fail;
 
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index 7b5ffd13a887..8907b09b86cc 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -136,7 +136,7 @@ static inline uint32_t fdt32_ld(const fdt32_t *p)
 
 static inline void fdt32_st(void *property, uint32_t value)
 {
-	uint8_t *bp = property;
+	uint8_t *bp = (uint8_t *)property;
 
 	bp[0] = value >> 24;
 	bp[1] = (value >> 16) & 0xff;
@@ -160,7 +160,7 @@ static inline uint64_t fdt64_ld(const fdt64_t *p)
 
 static inline void fdt64_st(void *property, uint64_t value)
 {
-	uint8_t *bp = property;
+	uint8_t *bp = (uint8_t *)property;
 
 	bp[0] = value >> 56;
 	bp[1] = (value >> 48) & 0xff;
diff --git a/scripts/dtc/libfdt/libfdt_internal.h b/scripts/dtc/libfdt/libfdt_internal.h
index 7830e550c37a..058c7358d441 100644
--- a/scripts/dtc/libfdt/libfdt_internal.h
+++ b/scripts/dtc/libfdt/libfdt_internal.h
@@ -10,12 +10,12 @@
 #define FDT_ALIGN(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 #define FDT_TAGALIGN(x)		(FDT_ALIGN((x), FDT_TAGSIZE))
 
-int fdt_ro_probe_(const void *fdt);
-#define FDT_RO_PROBE(fdt)			\
-	{ \
-		int err_; \
-		if ((err_ = fdt_ro_probe_(fdt)) != 0)	\
-			return err_; \
+int32_t fdt_ro_probe_(const void *fdt);
+#define FDT_RO_PROBE(fdt)					\
+	{							\
+		int32_t totalsize_;				\
+		if ((totalsize_ = fdt_ro_probe_(fdt)) < 0)	\
+			return totalsize_;			\
 	}
 
 int fdt_check_node_offset_(const void *fdt, int offset);
diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
index 0c039993953a..032df5878ccc 100644
--- a/scripts/dtc/livetree.c
+++ b/scripts/dtc/livetree.c
@@ -526,8 +526,7 @@ struct node *get_node_by_path(struct node *tree, const char *path)
 	p = strchr(path, '/');
 
 	for_each_child(tree, child) {
-		if (p && (strlen(child->name) == p-path) &&
-		    strprefixeq(path, p - path, child->name))
+		if (p && strprefixeq(path, p - path, child->name))
 			return get_node_by_path(child, p+1);
 		else if (!p && streq(path, child->name))
 			return child;
diff --git a/scripts/dtc/util.c b/scripts/dtc/util.c
index 48af961dcc8c..40274fb79236 100644
--- a/scripts/dtc/util.c
+++ b/scripts/dtc/util.c
@@ -13,6 +13,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <assert.h>
+#include <inttypes.h>
 
 #include <errno.h>
 #include <fcntl.h>
@@ -393,7 +394,7 @@ void utilfdt_print_data(const char *data, int len)
 
 		printf(" = <");
 		for (i = 0, len /= 4; i < len; i++)
-			printf("0x%08x%s", fdt32_to_cpu(cell[i]),
+			printf("0x%08" PRIx32 "%s", fdt32_to_cpu(cell[i]),
 			       i < (len - 1) ? " " : "");
 		printf(">");
 	} else {
diff --git a/scripts/dtc/util.h b/scripts/dtc/util.h
index ca5cb52928e3..5a4172dd0f84 100644
--- a/scripts/dtc/util.h
+++ b/scripts/dtc/util.h
@@ -12,7 +12,11 @@
  */
 
 #ifdef __GNUC__
+#ifdef __clang__
 #define PRINTF(i, j)	__attribute__((format (printf, i, j)))
+#else
+#define PRINTF(i, j)	__attribute__((format (gnu_printf, i, j)))
+#endif
 #define NORETURN	__attribute__((noreturn))
 #else
 #define PRINTF(i, j)
diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
index f2761e24cf40..6dba95d23207 100644
--- a/scripts/dtc/version_gen.h
+++ b/scripts/dtc/version_gen.h
@@ -1 +1 @@
-#define DTC_VERSION "DTC 1.5.0-g702c1b6c"
+#define DTC_VERSION "DTC 1.5.0-gc40aeb60"
diff --git a/scripts/dtc/yamltree.c b/scripts/dtc/yamltree.c
index 5b6ea8ea862f..43ca869dd6a8 100644
--- a/scripts/dtc/yamltree.c
+++ b/scripts/dtc/yamltree.c
@@ -138,6 +138,27 @@ static void yaml_propval(yaml_emitter_t *emitter, struct property *prop)
 		(yaml_char_t *)YAML_SEQ_TAG, 1, YAML_FLOW_SEQUENCE_STYLE);
 	yaml_emitter_emit_or_die(emitter, &event);
 
+	/* Ensure we have a type marker before any phandle */
+	for_each_marker(m) {
+		int last_offset = 0;
+		struct marker *type_m;
+
+		if (m->type >= TYPE_UINT8)
+			last_offset = m->offset;
+
+		if (!(m->next && m->next->type == REF_PHANDLE &&
+		      last_offset < m->next->offset))
+			continue;
+
+		type_m = xmalloc(sizeof(*type_m));
+		type_m->offset = m->next->offset;
+		type_m->type = TYPE_UINT32;
+		type_m->ref = NULL;
+		type_m->next = m->next;
+		m->next = type_m;
+	}
+
+	m = prop->val.markers;
 	for_each_marker(m) {
 		int chunk_len;
 		char *data = &prop->val.val[m->offset];
-- 
2.20.1

