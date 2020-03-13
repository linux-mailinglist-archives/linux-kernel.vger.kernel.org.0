Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42852184CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgCMQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 12:42:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36082 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCMQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:42:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id k18so10059932oib.3;
        Fri, 13 Mar 2020 09:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LTpwJfGmRyurqNRH8b2G4VmXXpA0xsKAYTJQS/fwDeU=;
        b=cTaYPPR4oGhJEw0/u2kqCGS4mnGcU2VVxypOpI0ZWs27ple4f9A4siQ7pnApN/t7Io
         ceWo+67CuWG3iyMPXCnYX5DvEAQbNtDHrBi2ElfjtTwKv/SSwhlmN9j/W1X3Ql2kYqPz
         GwQz7qh+2s3Ud4WRRgdPK9wYL49FZ5hUAqJVJpD9iiZf6mAKIknTyxnOzABasSIigd7L
         +IHlXWGmfPVtU9Kx7afcS1DMq7mYsFtmQZ6cgRXroZxJN5RqIj9bhhXAqsy014l1sVPL
         GZnzElZftS0EteAa9MS1j2RdGGF4tOt0JKOLiLDTD+JpZ0K5IkFekQdvHuv1Y+c/NUXm
         ItBQ==
X-Gm-Message-State: ANhLgQ3d282PVoQMYIkXBlGTA0FBqfSvTtDIQQ+M9w+Uv9QJryvQlOmA
        IZ8Sf1ZRfsegnK3azpsLD/QQySA=
X-Google-Smtp-Source: ADFU+vsvQFycXJLYrNPjGo6Wf9ZEMzaMwnqKVLjtVdEAUCihg2g4tfp4oc4NWwjG/qyddHCl0GX3Ag==
X-Received: by 2002:aca:4d86:: with SMTP id a128mr7901861oib.96.1584117742519;
        Fri, 13 Mar 2020 09:42:22 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 90sm1171112otc.29.2020.03.13.09.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 09:42:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] scripts/dtc: Update to upstream version v1.6.0-2-g87a656ae5ff9
Date:   Fri, 13 Mar 2020 11:42:20 -0500
Message-Id: <20200313164220.15868-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the following commits from upstream:

87a656ae5ff9 check: Inform about missing ranges
73d6e9ecb417 libfdt: fix undefined behaviour in fdt_splice_()
2525da3dba9b Bump version to v1.6.0
62cb4ad286ff Execute tests on FreeBSD with Cirrus CI
1f9a41750883 tests: Allow running the testsuite on already installed binary / libraries
c5995ddf4c20 tests: Honour NO_YAML make variable
e4ce227e89d7 tests: Properly clean up .bak file from tests
9b75292c335c tests: Honour $(NO_PYTHON) flag from Makefile in run_tests.sh
6c253afd07d4 Encode $(NO_PYTHON) consistently with other variables
95ec8ef706bd tests: No need to explicitly pass $PYTHON from Make to run_tests.sh
2b5f62d109a2 tests: Let run_tests.sh run Python tests without Makefile assistance
76b43dcbd18a checks: Add 'dma-ranges' check
e5c92a4780c6 libfdt: Use VALID_INPUT for FDT_ERR_BADSTATE checks
e5cc26b68bc0 libfdt: Add support for disabling internal checks
28fd7590aad2 libfdt: Improve comments in some of the assumptions
fc207c32341b libfdt: Fix a few typos
0f61c72dedc4 libfdt: Allow exclusion of fdt_check_full()
f270f45fd5d2 libfdt: Add support for disabling ordering check/fixup
c18bae9a4c96 libfdt: Add support for disabling version checks
fc03c4a2e04e libfdt: Add support for disabling rollback handling
77563ae72b7c libfdt: Add support for disabling sanity checks
57bc6327b80b libfdt: Add support for disabling dtb checks
464962489dcc Add a way to control the level of checks in the code
0c5326cb2845 libfdt: De-inline fdt_header_size()
cc6a5a071504 Revert "yamltree: Ensure consistent bracketing of properties with phandles"
0e9225eb0dfe Remove redundant YYLOC global declaration
cab09eedd644 Move -DNO_VALGRIND into CPPFLAGS
0eb1cb0b531e Makefile: pass $(CFLAGS) also during dependency generation

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/checks.c                 |  25 ++---
 scripts/dtc/dtc-lexer.l              |   1 -
 scripts/dtc/libfdt/fdt.c             |  99 ++++++++++++-------
 scripts/dtc/libfdt/fdt_ro.c          | 143 ++++++++++-----------------
 scripts/dtc/libfdt/fdt_rw.c          |  42 +++++---
 scripts/dtc/libfdt/fdt_sw.c          |  19 ++--
 scripts/dtc/libfdt/libfdt.h          |   9 +-
 scripts/dtc/libfdt/libfdt_internal.h | 122 +++++++++++++++++++++++
 scripts/dtc/version_gen.h            |   2 +-
 9 files changed, 296 insertions(+), 166 deletions(-)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 756f0fa9203f..4b3c486f1399 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -352,7 +352,7 @@ static void check_unit_address_vs_reg(struct check *c, struct dt_info *dti,
 			FAIL(c, dti, node, "node has a reg or ranges property, but no unit name");
 	} else {
 		if (unitname[0])
-			FAIL(c, dti, node, "node has a unit name, but no reg property");
+			FAIL(c, dti, node, "node has a unit name, but no reg or ranges property");
 	}
 }
 WARNING(unit_address_vs_reg, check_unit_address_vs_reg, NULL);
@@ -765,13 +765,15 @@ static void check_ranges_format(struct check *c, struct dt_info *dti,
 {
 	struct property *prop;
 	int c_addr_cells, p_addr_cells, c_size_cells, p_size_cells, entrylen;
+	const char *ranges = c->data;
 
-	prop = get_property(node, "ranges");
+	prop = get_property(node, ranges);
 	if (!prop)
 		return;
 
 	if (!node->parent) {
-		FAIL_PROP(c, dti, node, prop, "Root node has a \"ranges\" property");
+		FAIL_PROP(c, dti, node, prop, "Root node has a \"%s\" property",
+			  ranges);
 		return;
 	}
 
@@ -783,23 +785,24 @@ static void check_ranges_format(struct check *c, struct dt_info *dti,
 
 	if (prop->val.len == 0) {
 		if (p_addr_cells != c_addr_cells)
-			FAIL_PROP(c, dti, node, prop, "empty \"ranges\" property but its "
+			FAIL_PROP(c, dti, node, prop, "empty \"%s\" property but its "
 				  "#address-cells (%d) differs from %s (%d)",
-				  c_addr_cells, node->parent->fullpath,
+				  ranges, c_addr_cells, node->parent->fullpath,
 				  p_addr_cells);
 		if (p_size_cells != c_size_cells)
-			FAIL_PROP(c, dti, node, prop, "empty \"ranges\" property but its "
+			FAIL_PROP(c, dti, node, prop, "empty \"%s\" property but its "
 				  "#size-cells (%d) differs from %s (%d)",
-				  c_size_cells, node->parent->fullpath,
+				  ranges, c_size_cells, node->parent->fullpath,
 				  p_size_cells);
 	} else if ((prop->val.len % entrylen) != 0) {
-		FAIL_PROP(c, dti, node, prop, "\"ranges\" property has invalid length (%d bytes) "
+		FAIL_PROP(c, dti, node, prop, "\"%s\" property has invalid length (%d bytes) "
 			  "(parent #address-cells == %d, child #address-cells == %d, "
-			  "#size-cells == %d)", prop->val.len,
+			  "#size-cells == %d)", ranges, prop->val.len,
 			  p_addr_cells, c_addr_cells, c_size_cells);
 	}
 }
-WARNING(ranges_format, check_ranges_format, NULL, &addr_size_cells);
+WARNING(ranges_format, check_ranges_format, "ranges", &addr_size_cells);
+WARNING(dma_ranges_format, check_ranges_format, "dma-ranges", &addr_size_cells);
 
 static const struct bus_type pci_bus = {
 	.name = "PCI",
@@ -1780,7 +1783,7 @@ static struct check *check_table[] = {
 	&property_name_chars_strict,
 	&node_name_chars_strict,
 
-	&addr_size_cells, &reg_format, &ranges_format,
+	&addr_size_cells, &reg_format, &ranges_format, &dma_ranges_format,
 
 	&unit_address_vs_reg,
 	&unit_address_format,
diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
index 5c6c3fd557d7..b3b7270300de 100644
--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -23,7 +23,6 @@ LINECOMMENT	"//".*\n
 #include "srcpos.h"
 #include "dtc-parser.tab.h"
 
-YYLTYPE yylloc;
 extern bool treesource_error;
 
 /* CAUTION: this will stop working if we ever use yyless() or yyunput() */
diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
index d6ce7c052dc8..c28fcc115771 100644
--- a/scripts/dtc/libfdt/fdt.c
+++ b/scripts/dtc/libfdt/fdt.c
@@ -19,15 +19,21 @@ int32_t fdt_ro_probe_(const void *fdt)
 {
 	uint32_t totalsize = fdt_totalsize(fdt);
 
+	if (can_assume(VALID_DTB))
+		return totalsize;
+
 	if (fdt_magic(fdt) == FDT_MAGIC) {
 		/* Complete tree */
-		if (fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
-			return -FDT_ERR_BADVERSION;
-		if (fdt_last_comp_version(fdt) > FDT_LAST_SUPPORTED_VERSION)
-			return -FDT_ERR_BADVERSION;
+		if (!can_assume(LATEST)) {
+			if (fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
+				return -FDT_ERR_BADVERSION;
+			if (fdt_last_comp_version(fdt) >
+					FDT_LAST_SUPPORTED_VERSION)
+				return -FDT_ERR_BADVERSION;
+		}
 	} else if (fdt_magic(fdt) == FDT_SW_MAGIC) {
 		/* Unfinished sequential-write blob */
-		if (fdt_size_dt_struct(fdt) == 0)
+		if (!can_assume(VALID_INPUT) && fdt_size_dt_struct(fdt) == 0)
 			return -FDT_ERR_BADSTATE;
 	} else {
 		return -FDT_ERR_BADMAGIC;
@@ -70,44 +76,59 @@ size_t fdt_header_size_(uint32_t version)
 		return FDT_V17_SIZE;
 }
 
+size_t fdt_header_size(const void *fdt)
+{
+	return can_assume(LATEST) ? FDT_V17_SIZE :
+		fdt_header_size_(fdt_version(fdt));
+}
+
 int fdt_check_header(const void *fdt)
 {
 	size_t hdrsize;
 
 	if (fdt_magic(fdt) != FDT_MAGIC)
 		return -FDT_ERR_BADMAGIC;
+	if (!can_assume(LATEST)) {
+		if ((fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
+		    || (fdt_last_comp_version(fdt) >
+			FDT_LAST_SUPPORTED_VERSION))
+			return -FDT_ERR_BADVERSION;
+		if (fdt_version(fdt) < fdt_last_comp_version(fdt))
+			return -FDT_ERR_BADVERSION;
+	}
 	hdrsize = fdt_header_size(fdt);
-	if ((fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
-	    || (fdt_last_comp_version(fdt) > FDT_LAST_SUPPORTED_VERSION))
-		return -FDT_ERR_BADVERSION;
-	if (fdt_version(fdt) < fdt_last_comp_version(fdt))
-		return -FDT_ERR_BADVERSION;
-
-	if ((fdt_totalsize(fdt) < hdrsize)
-	    || (fdt_totalsize(fdt) > INT_MAX))
-		return -FDT_ERR_TRUNCATED;
+	if (!can_assume(VALID_DTB)) {
 
-	/* Bounds check memrsv block */
-	if (!check_off_(hdrsize, fdt_totalsize(fdt), fdt_off_mem_rsvmap(fdt)))
-		return -FDT_ERR_TRUNCATED;
+		if ((fdt_totalsize(fdt) < hdrsize)
+		    || (fdt_totalsize(fdt) > INT_MAX))
+			return -FDT_ERR_TRUNCATED;
 
-	/* Bounds check structure block */
-	if (fdt_version(fdt) < 17) {
+		/* Bounds check memrsv block */
 		if (!check_off_(hdrsize, fdt_totalsize(fdt),
-				fdt_off_dt_struct(fdt)))
+				fdt_off_mem_rsvmap(fdt)))
 			return -FDT_ERR_TRUNCATED;
-	} else {
+	}
+
+	if (!can_assume(VALID_DTB)) {
+		/* Bounds check structure block */
+		if (!can_assume(LATEST) && fdt_version(fdt) < 17) {
+			if (!check_off_(hdrsize, fdt_totalsize(fdt),
+					fdt_off_dt_struct(fdt)))
+				return -FDT_ERR_TRUNCATED;
+		} else {
+			if (!check_block_(hdrsize, fdt_totalsize(fdt),
+					  fdt_off_dt_struct(fdt),
+					  fdt_size_dt_struct(fdt)))
+				return -FDT_ERR_TRUNCATED;
+		}
+
+		/* Bounds check strings block */
 		if (!check_block_(hdrsize, fdt_totalsize(fdt),
-				  fdt_off_dt_struct(fdt),
-				  fdt_size_dt_struct(fdt)))
+				  fdt_off_dt_strings(fdt),
+				  fdt_size_dt_strings(fdt)))
 			return -FDT_ERR_TRUNCATED;
 	}
 
-	/* Bounds check strings block */
-	if (!check_block_(hdrsize, fdt_totalsize(fdt),
-			  fdt_off_dt_strings(fdt), fdt_size_dt_strings(fdt)))
-		return -FDT_ERR_TRUNCATED;
-
 	return 0;
 }
 
@@ -115,12 +136,13 @@ const void *fdt_offset_ptr(const void *fdt, int offset, unsigned int len)
 {
 	unsigned absoffset = offset + fdt_off_dt_struct(fdt);
 
-	if ((absoffset < offset)
-	    || ((absoffset + len) < absoffset)
-	    || (absoffset + len) > fdt_totalsize(fdt))
-		return NULL;
+	if (!can_assume(VALID_INPUT))
+		if ((absoffset < offset)
+		    || ((absoffset + len) < absoffset)
+		    || (absoffset + len) > fdt_totalsize(fdt))
+			return NULL;
 
-	if (fdt_version(fdt) >= 0x11)
+	if (can_assume(LATEST) || fdt_version(fdt) >= 0x11)
 		if (((offset + len) < offset)
 		    || ((offset + len) > fdt_size_dt_struct(fdt)))
 			return NULL;
@@ -137,7 +159,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 
 	*nextoffset = -FDT_ERR_TRUNCATED;
 	tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
-	if (!tagp)
+	if (!can_assume(VALID_DTB) && !tagp)
 		return FDT_END; /* premature end */
 	tag = fdt32_to_cpu(*tagp);
 	offset += FDT_TAGSIZE;
@@ -149,18 +171,19 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 		do {
 			p = fdt_offset_ptr(fdt, offset++, 1);
 		} while (p && (*p != '\0'));
-		if (!p)
+		if (!can_assume(VALID_DTB) && !p)
 			return FDT_END; /* premature end */
 		break;
 
 	case FDT_PROP:
 		lenp = fdt_offset_ptr(fdt, offset, sizeof(*lenp));
-		if (!lenp)
+		if (!can_assume(VALID_DTB) && !lenp)
 			return FDT_END; /* premature end */
 		/* skip-name offset, length and value */
 		offset += sizeof(struct fdt_property) - FDT_TAGSIZE
 			+ fdt32_to_cpu(*lenp);
-		if (fdt_version(fdt) < 0x10 && fdt32_to_cpu(*lenp) >= 8 &&
+		if (!can_assume(LATEST) &&
+		    fdt_version(fdt) < 0x10 && fdt32_to_cpu(*lenp) >= 8 &&
 		    ((offset - fdt32_to_cpu(*lenp)) % 8) != 0)
 			offset += 4;
 		break;
@@ -183,6 +206,8 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 
 int fdt_check_node_offset_(const void *fdt, int offset)
 {
+	if (can_assume(VALID_INPUT))
+		return offset;
 	if ((offset < 0) || (offset % FDT_TAGSIZE)
 	    || (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE))
 		return -FDT_ERR_BADOFFSET;
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index a5c2797cde65..e03570a56eb5 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -33,17 +33,26 @@ static int fdt_nodename_eq_(const void *fdt, int offset,
 
 const char *fdt_get_string(const void *fdt, int stroffset, int *lenp)
 {
-	int32_t totalsize = fdt_ro_probe_(fdt);
-	uint32_t absoffset = stroffset + fdt_off_dt_strings(fdt);
+	int32_t totalsize;
+	uint32_t absoffset;
 	size_t len;
 	int err;
 	const char *s, *n;
 
+	if (can_assume(VALID_INPUT)) {
+		s = (const char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
+
+		if (lenp)
+			*lenp = strlen(s);
+		return s;
+	}
+	totalsize = fdt_ro_probe_(fdt);
 	err = totalsize;
 	if (totalsize < 0)
 		goto fail;
 
 	err = -FDT_ERR_BADOFFSET;
+	absoffset = stroffset + fdt_off_dt_strings(fdt);
 	if (absoffset >= totalsize)
 		goto fail;
 	len = totalsize - absoffset;
@@ -51,7 +60,7 @@ const char *fdt_get_string(const void *fdt, int stroffset, int *lenp)
 	if (fdt_magic(fdt) == FDT_MAGIC) {
 		if (stroffset < 0)
 			goto fail;
-		if (fdt_version(fdt) >= 17) {
+		if (can_assume(LATEST) || fdt_version(fdt) >= 17) {
 			if (stroffset >= fdt_size_dt_strings(fdt))
 				goto fail;
 			if ((fdt_size_dt_strings(fdt) - stroffset) < len)
@@ -151,10 +160,13 @@ static const struct fdt_reserve_entry *fdt_mem_rsv(const void *fdt, int n)
 	int offset = n * sizeof(struct fdt_reserve_entry);
 	int absoffset = fdt_off_mem_rsvmap(fdt) + offset;
 
-	if (absoffset < fdt_off_mem_rsvmap(fdt))
-		return NULL;
-	if (absoffset > fdt_totalsize(fdt) - sizeof(struct fdt_reserve_entry))
-		return NULL;
+	if (!can_assume(VALID_INPUT)) {
+		if (absoffset < fdt_off_mem_rsvmap(fdt))
+			return NULL;
+		if (absoffset > fdt_totalsize(fdt) -
+		    sizeof(struct fdt_reserve_entry))
+			return NULL;
+	}
 	return fdt_mem_rsv_(fdt, n);
 }
 
@@ -164,7 +176,7 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
 
 	FDT_RO_PROBE(fdt);
 	re = fdt_mem_rsv(fdt, n);
-	if (!re)
+	if (!can_assume(VALID_INPUT) && !re)
 		return -FDT_ERR_BADOFFSET;
 
 	*address = fdt64_ld(&re->address);
@@ -295,7 +307,7 @@ const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
 
 	nameptr = nh->name;
 
-	if (fdt_version(fdt) < 0x10) {
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
 		/*
 		 * For old FDT versions, match the naming conventions of V16:
 		 * give only the leaf name (after all /). The actual tree
@@ -346,7 +358,8 @@ static const struct fdt_property *fdt_get_property_by_offset_(const void *fdt,
 	int err;
 	const struct fdt_property *prop;
 
-	if ((err = fdt_check_prop_offset_(fdt, offset)) < 0) {
+	if (!can_assume(VALID_INPUT) &&
+	    (err = fdt_check_prop_offset_(fdt, offset)) < 0) {
 		if (lenp)
 			*lenp = err;
 		return NULL;
@@ -367,7 +380,7 @@ const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
 	/* Prior to version 16, properties may need realignment
 	 * and this API does not work. fdt_getprop_*() will, however. */
 
-	if (fdt_version(fdt) < 0x10) {
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
 		if (lenp)
 			*lenp = -FDT_ERR_BADVERSION;
 		return NULL;
@@ -388,7 +401,8 @@ static const struct fdt_property *fdt_get_property_namelen_(const void *fdt,
 	     (offset = fdt_next_property_offset(fdt, offset))) {
 		const struct fdt_property *prop;
 
-		if (!(prop = fdt_get_property_by_offset_(fdt, offset, lenp))) {
+		prop = fdt_get_property_by_offset_(fdt, offset, lenp);
+		if (!can_assume(LIBFDT_FLAWLESS) && !prop) {
 			offset = -FDT_ERR_INTERNAL;
 			break;
 		}
@@ -413,7 +427,7 @@ const struct fdt_property *fdt_get_property_namelen(const void *fdt,
 {
 	/* Prior to version 16, properties may need realignment
 	 * and this API does not work. fdt_getprop_*() will, however. */
-	if (fdt_version(fdt) < 0x10) {
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
 		if (lenp)
 			*lenp = -FDT_ERR_BADVERSION;
 		return NULL;
@@ -444,8 +458,8 @@ const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
 		return NULL;
 
 	/* Handle realignment */
-	if (fdt_version(fdt) < 0x10 && (poffset + sizeof(*prop)) % 8 &&
-	    fdt32_ld(&prop->len) >= 8)
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10 &&
+	    (poffset + sizeof(*prop)) % 8 && fdt32_ld(&prop->len) >= 8)
 		return prop->data + 4;
 	return prop->data;
 }
@@ -461,19 +475,24 @@ const void *fdt_getprop_by_offset(const void *fdt, int offset,
 	if (namep) {
 		const char *name;
 		int namelen;
-		name = fdt_get_string(fdt, fdt32_ld(&prop->nameoff),
-				      &namelen);
-		if (!name) {
-			if (lenp)
-				*lenp = namelen;
-			return NULL;
+
+		if (!can_assume(VALID_INPUT)) {
+			name = fdt_get_string(fdt, fdt32_ld(&prop->nameoff),
+					      &namelen);
+			if (!name) {
+				if (lenp)
+					*lenp = namelen;
+				return NULL;
+			}
+			*namep = name;
+		} else {
+			*namep = fdt_string(fdt, fdt32_ld(&prop->nameoff));
 		}
-		*namep = name;
 	}
 
 	/* Handle realignment */
-	if (fdt_version(fdt) < 0x10 && (offset + sizeof(*prop)) % 8 &&
-	    fdt32_ld(&prop->len) >= 8)
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10 &&
+	    (offset + sizeof(*prop)) % 8 && fdt32_ld(&prop->len) >= 8)
 		return prop->data + 4;
 	return prop->data;
 }
@@ -598,10 +617,12 @@ int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
 		}
 	}
 
-	if ((offset == -FDT_ERR_NOTFOUND) || (offset >= 0))
-		return -FDT_ERR_BADOFFSET;
-	else if (offset == -FDT_ERR_BADOFFSET)
-		return -FDT_ERR_BADSTRUCTURE;
+	if (!can_assume(VALID_INPUT)) {
+		if ((offset == -FDT_ERR_NOTFOUND) || (offset >= 0))
+			return -FDT_ERR_BADOFFSET;
+		else if (offset == -FDT_ERR_BADOFFSET)
+			return -FDT_ERR_BADSTRUCTURE;
+	}
 
 	return offset; /* error from fdt_next_node() */
 }
@@ -613,7 +634,8 @@ int fdt_node_depth(const void *fdt, int nodeoffset)
 
 	err = fdt_supernode_atdepth_offset(fdt, nodeoffset, 0, &nodedepth);
 	if (err)
-		return (err < 0) ? err : -FDT_ERR_INTERNAL;
+		return (can_assume(LIBFDT_FLAWLESS) || err < 0) ? err :
+			-FDT_ERR_INTERNAL;
 	return nodedepth;
 }
 
@@ -833,66 +855,3 @@ int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
 
 	return offset; /* error from fdt_next_node() */
 }
-
-int fdt_check_full(const void *fdt, size_t bufsize)
-{
-	int err;
-	int num_memrsv;
-	int offset, nextoffset = 0;
-	uint32_t tag;
-	unsigned depth = 0;
-	const void *prop;
-	const char *propname;
-
-	if (bufsize < FDT_V1_SIZE)
-		return -FDT_ERR_TRUNCATED;
-	err = fdt_check_header(fdt);
-	if (err != 0)
-		return err;
-	if (bufsize < fdt_totalsize(fdt))
-		return -FDT_ERR_TRUNCATED;
-
-	num_memrsv = fdt_num_mem_rsv(fdt);
-	if (num_memrsv < 0)
-		return num_memrsv;
-
-	while (1) {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-
-		if (nextoffset < 0)
-			return nextoffset;
-
-		switch (tag) {
-		case FDT_NOP:
-			break;
-
-		case FDT_END:
-			if (depth != 0)
-				return -FDT_ERR_BADSTRUCTURE;
-			return 0;
-
-		case FDT_BEGIN_NODE:
-			depth++;
-			if (depth > INT_MAX)
-				return -FDT_ERR_BADSTRUCTURE;
-			break;
-
-		case FDT_END_NODE:
-			if (depth == 0)
-				return -FDT_ERR_BADSTRUCTURE;
-			depth--;
-			break;
-
-		case FDT_PROP:
-			prop = fdt_getprop_by_offset(fdt, offset, &propname,
-						     &err);
-			if (!prop)
-				return err;
-			break;
-
-		default:
-			return -FDT_ERR_INTERNAL;
-		}
-	}
-}
diff --git a/scripts/dtc/libfdt/fdt_rw.c b/scripts/dtc/libfdt/fdt_rw.c
index 8795947c00dd..524b520c8486 100644
--- a/scripts/dtc/libfdt/fdt_rw.c
+++ b/scripts/dtc/libfdt/fdt_rw.c
@@ -24,14 +24,16 @@ static int fdt_blocks_misordered_(const void *fdt,
 
 static int fdt_rw_probe_(void *fdt)
 {
+	if (can_assume(VALID_DTB))
+		return 0;
 	FDT_RO_PROBE(fdt);
 
-	if (fdt_version(fdt) < 17)
+	if (!can_assume(LATEST) && fdt_version(fdt) < 17)
 		return -FDT_ERR_BADVERSION;
 	if (fdt_blocks_misordered_(fdt, sizeof(struct fdt_reserve_entry),
 				   fdt_size_dt_struct(fdt)))
 		return -FDT_ERR_BADLAYOUT;
-	if (fdt_version(fdt) > 17)
+	if (!can_assume(LATEST) && fdt_version(fdt) > 17)
 		fdt_set_version(fdt, 17);
 
 	return 0;
@@ -44,7 +46,7 @@ static int fdt_rw_probe_(void *fdt)
 			return err_; \
 	}
 
-static inline int fdt_data_size_(void *fdt)
+static inline unsigned int fdt_data_size_(void *fdt)
 {
 	return fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 }
@@ -52,15 +54,16 @@ static inline int fdt_data_size_(void *fdt)
 static int fdt_splice_(void *fdt, void *splicepoint, int oldlen, int newlen)
 {
 	char *p = splicepoint;
-	char *end = (char *)fdt + fdt_data_size_(fdt);
+	unsigned int dsize = fdt_data_size_(fdt);
+	size_t soff = p - (char *)fdt;
 
-	if (((p + oldlen) < p) || ((p + oldlen) > end))
+	if ((oldlen < 0) || (soff + oldlen < soff) || (soff + oldlen > dsize))
 		return -FDT_ERR_BADOFFSET;
-	if ((p < (char *)fdt) || ((end - oldlen + newlen) < (char *)fdt))
+	if ((p < (char *)fdt) || (dsize + newlen < oldlen))
 		return -FDT_ERR_BADOFFSET;
-	if ((end - oldlen + newlen) > ((char *)fdt + fdt_totalsize(fdt)))
+	if (dsize - oldlen + newlen > fdt_totalsize(fdt))
 		return -FDT_ERR_NOSPACE;
-	memmove(p + newlen, p + oldlen, end - p - oldlen);
+	memmove(p + newlen, p + oldlen, ((char *)fdt + dsize) - (p + oldlen));
 	return 0;
 }
 
@@ -112,6 +115,15 @@ static int fdt_splice_string_(void *fdt, int newlen)
 	return 0;
 }
 
+/**
+ * fdt_find_add_string_() - Find or allocate a string
+ *
+ * @fdt: pointer to the device tree to check/adjust
+ * @s: string to find/add
+ * @allocated: Set to 0 if the string was found, 1 if not found and so
+ *	allocated. Ignored if can_assume(NO_ROLLBACK)
+ * @return offset of string in the string table (whether found or added)
+ */
 static int fdt_find_add_string_(void *fdt, const char *s, int *allocated)
 {
 	char *strtab = (char *)fdt + fdt_off_dt_strings(fdt);
@@ -120,7 +132,8 @@ static int fdt_find_add_string_(void *fdt, const char *s, int *allocated)
 	int len = strlen(s) + 1;
 	int err;
 
-	*allocated = 0;
+	if (!can_assume(NO_ROLLBACK))
+		*allocated = 0;
 
 	p = fdt_find_string_(strtab, fdt_size_dt_strings(fdt), s);
 	if (p)
@@ -132,7 +145,8 @@ static int fdt_find_add_string_(void *fdt, const char *s, int *allocated)
 	if (err)
 		return err;
 
-	*allocated = 1;
+	if (!can_assume(NO_ROLLBACK))
+		*allocated = 1;
 
 	memcpy(new, s, len);
 	return (new - strtab);
@@ -206,7 +220,8 @@ static int fdt_add_property_(void *fdt, int nodeoffset, const char *name,
 
 	err = fdt_splice_struct_(fdt, *prop, 0, proplen);
 	if (err) {
-		if (allocated)
+		/* Delete the string if we failed to add it */
+		if (!can_assume(NO_ROLLBACK) && allocated)
 			fdt_del_last_string_(fdt, name);
 		return err;
 	}
@@ -411,7 +426,7 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);
 
-	if (fdt_version(fdt) >= 17) {
+	if (can_assume(LATEST) || fdt_version(fdt) >= 17) {
 		struct_size = fdt_size_dt_struct(fdt);
 	} else {
 		struct_size = 0;
@@ -421,7 +436,8 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
 			return struct_size;
 	}
 
-	if (!fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
+	if (can_assume(LIBFDT_ORDER) |
+	    !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
 		/* no further work necessary */
 		err = fdt_move(fdt, buf, bufsize);
 		if (err)
diff --git a/scripts/dtc/libfdt/fdt_sw.c b/scripts/dtc/libfdt/fdt_sw.c
index 76bea22f734f..26759d5dfb8c 100644
--- a/scripts/dtc/libfdt/fdt_sw.c
+++ b/scripts/dtc/libfdt/fdt_sw.c
@@ -12,10 +12,13 @@
 
 static int fdt_sw_probe_(void *fdt)
 {
-	if (fdt_magic(fdt) == FDT_MAGIC)
-		return -FDT_ERR_BADSTATE;
-	else if (fdt_magic(fdt) != FDT_SW_MAGIC)
-		return -FDT_ERR_BADMAGIC;
+	if (!can_assume(VALID_INPUT)) {
+		if (fdt_magic(fdt) == FDT_MAGIC)
+			return -FDT_ERR_BADSTATE;
+		else if (fdt_magic(fdt) != FDT_SW_MAGIC)
+			return -FDT_ERR_BADMAGIC;
+	}
+
 	return 0;
 }
 
@@ -38,7 +41,7 @@ static int fdt_sw_probe_memrsv_(void *fdt)
 	if (err)
 		return err;
 
-	if (fdt_off_dt_strings(fdt) != 0)
+	if (!can_assume(VALID_INPUT) && fdt_off_dt_strings(fdt) != 0)
 		return -FDT_ERR_BADSTATE;
 	return 0;
 }
@@ -64,7 +67,8 @@ static int fdt_sw_probe_struct_(void *fdt)
 	if (err)
 		return err;
 
-	if (fdt_off_dt_strings(fdt) != fdt_totalsize(fdt))
+	if (!can_assume(VALID_INPUT) &&
+	    fdt_off_dt_strings(fdt) != fdt_totalsize(fdt))
 		return -FDT_ERR_BADSTATE;
 	return 0;
 }
@@ -151,7 +155,8 @@ int fdt_resize(void *fdt, void *buf, int bufsize)
 	headsize = fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt);
 	tailsize = fdt_size_dt_strings(fdt);
 
-	if ((headsize + tailsize) > fdt_totalsize(fdt))
+	if (!can_assume(VALID_DTB) &&
+	    headsize + tailsize > fdt_totalsize(fdt))
 		return -FDT_ERR_INTERNAL;
 
 	if ((headsize + tailsize) > bufsize)
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index 8907b09b86cc..36fadcdea516 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -266,11 +266,12 @@ fdt_set_hdr_(size_dt_struct);
  * fdt_header_size - return the size of the tree's header
  * @fdt: pointer to a flattened device tree
  */
+size_t fdt_header_size(const void *fdt);
+
+/**
+ * fdt_header_size_ - internal function which takes a version number
+ */
 size_t fdt_header_size_(uint32_t version);
-static inline size_t fdt_header_size(const void *fdt)
-{
-	return fdt_header_size_(fdt_version(fdt));
-}
 
 /**
  * fdt_check_header - sanity check a device tree header
diff --git a/scripts/dtc/libfdt/libfdt_internal.h b/scripts/dtc/libfdt/libfdt_internal.h
index 058c7358d441..d4e0bd49c037 100644
--- a/scripts/dtc/libfdt/libfdt_internal.h
+++ b/scripts/dtc/libfdt/libfdt_internal.h
@@ -48,4 +48,126 @@ static inline struct fdt_reserve_entry *fdt_mem_rsv_w_(void *fdt, int n)
 
 #define FDT_SW_MAGIC		(~FDT_MAGIC)
 
+/**********************************************************************/
+/* Checking controls                                                  */
+/**********************************************************************/
+
+#ifndef FDT_ASSUME_MASK
+#define FDT_ASSUME_MASK 0
+#endif
+
+/*
+ * Defines assumptions which can be enabled. Each of these can be enabled
+ * individually. For maximum safety, don't enable any assumptions!
+ *
+ * For minimal code size and no safety, use ASSUME_PERFECT at your own risk.
+ * You should have another method of validating the device tree, such as a
+ * signature or hash check before using libfdt.
+ *
+ * For situations where security is not a concern it may be safe to enable
+ * ASSUME_SANE.
+ */
+enum {
+	/*
+	 * This does essentially no checks. Only the latest device-tree
+	 * version is correctly handled. Inconsistencies or errors in the device
+	 * tree may cause undefined behaviour or crashes. Invalid parameters
+	 * passed to libfdt may do the same.
+	 *
+	 * If an error occurs when modifying the tree it may leave the tree in
+	 * an intermediate (but valid) state. As an example, adding a property
+	 * where there is insufficient space may result in the property name
+	 * being added to the string table even though the property itself is
+	 * not added to the struct section.
+	 *
+	 * Only use this if you have a fully validated device tree with
+	 * the latest supported version and wish to minimise code size.
+	 */
+	ASSUME_PERFECT		= 0xff,
+
+	/*
+	 * This assumes that the device tree is sane. i.e. header metadata
+	 * and basic hierarchy are correct.
+	 *
+	 * With this assumption enabled, normal device trees produced by libfdt
+	 * and the compiler should be handled safely. Malicious device trees and
+	 * complete garbage may cause libfdt to behave badly or crash. Truncated
+	 * device trees (e.g. those only partially loaded) can also cause
+	 * problems.
+	 *
+	 * Note: Only checks that relate exclusively to the device tree itself
+	 * (not the parameters passed to libfdt) are disabled by this
+	 * assumption. This includes checking headers, tags and the like.
+	 */
+	ASSUME_VALID_DTB	= 1 << 0,
+
+	/*
+	 * This builds on ASSUME_VALID_DTB and further assumes that libfdt
+	 * functions are called with valid parameters, i.e. not trigger
+	 * FDT_ERR_BADOFFSET or offsets that are out of bounds. It disables any
+	 * extensive checking of parameters and the device tree, making various
+	 * assumptions about correctness.
+	 *
+	 * It doesn't make sense to enable this assumption unless
+	 * ASSUME_VALID_DTB is also enabled.
+	 */
+	ASSUME_VALID_INPUT	= 1 << 1,
+
+	/*
+	 * This disables checks for device-tree version and removes all code
+	 * which handles older versions.
+	 *
+	 * Only enable this if you know you have a device tree with the latest
+	 * version.
+	 */
+	ASSUME_LATEST		= 1 << 2,
+
+	/*
+	 * This assumes that it is OK for a failed addition to the device tree,
+	 * due to lack of space or some other problem, to skip any rollback
+	 * steps (such as dropping the property name from the string table).
+	 * This is safe to enable in most circumstances, even though it may
+	 * leave the tree in a sub-optimal state.
+	 */
+	ASSUME_NO_ROLLBACK	= 1 << 3,
+
+	/*
+	 * This assumes that the device tree components appear in a 'convenient'
+	 * order, i.e. the memory reservation block first, then the structure
+	 * block and finally the string block.
+	 *
+	 * This order is not specified by the device-tree specification,
+	 * but is expected by libfdt. The device-tree compiler always created
+	 * device trees with this order.
+	 *
+	 * This assumption disables a check in fdt_open_into() and removes the
+	 * ability to fix the problem there. This is safe if you know that the
+	 * device tree is correctly ordered. See fdt_blocks_misordered_().
+	 */
+	ASSUME_LIBFDT_ORDER	= 1 << 4,
+
+	/*
+	 * This assumes that libfdt itself does not have any internal bugs. It
+	 * drops certain checks that should never be needed unless libfdt has an
+	 * undiscovered bug.
+	 *
+	 * This can generally be considered safe to enable.
+	 */
+	ASSUME_LIBFDT_FLAWLESS	= 1 << 5,
+};
+
+/**
+ * can_assume_() - check if a particular assumption is enabled
+ *
+ * @mask: Mask to check (ASSUME_...)
+ * @return true if that assumption is enabled, else false
+ */
+static inline bool can_assume_(int mask)
+{
+	return FDT_ASSUME_MASK & mask;
+}
+
+/** helper macros for checking assumptions */
+#define can_assume(_assume)	can_assume_(ASSUME_ ## _assume)
+
 #endif /* LIBFDT_INTERNAL_H */
diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
index 6dba95d23207..61dd7112d6e4 100644
--- a/scripts/dtc/version_gen.h
+++ b/scripts/dtc/version_gen.h
@@ -1 +1 @@
-#define DTC_VERSION "DTC 1.5.0-gc40aeb60"
+#define DTC_VERSION "DTC 1.6.0-g87a656ae"
-- 
2.20.1

