Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D89173E42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgB1RUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 12:20:24 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:50025 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:20:22 -0500
Received: by mail-wr1-f73.google.com with SMTP id w6so1608870wrm.16
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J1M2XLrXGsvQG61qq/obE84N3dNLneXy1mWEldFInts=;
        b=XjXoCgsSfTy56ylcFST9gATMRLMhYF0GKahSkShnMyatFoxxMU/XQxPH1YTnDZpgY+
         QQ8OInypLFfEbaDDEB/ck/FIv/Vz5CNguqofPFvj6mqxPdfHgStaloNzO/dEuhllDYx0
         Kn7njdap21Msp/7C6w4k65UtboxxwqjD6p3ostzCq1TrUsz/p2tphkQe5wDjxbyazucn
         kQ2Y2bvXg+WNQtvQKadNEtZNZos5PObEWnuVxbSHUZtdYoWGFzgf8rWFZRnyK8iqwwAJ
         GA7hr78UihFSoz2hgUDEbbTrTdF8/9prdgZQq0gp7xwOpjfkceTSeMTJpS528SvT6qxd
         KOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J1M2XLrXGsvQG61qq/obE84N3dNLneXy1mWEldFInts=;
        b=pYbkgdvt2rpzsZDZsKJdkh7YgV5ENiFZxsI9jFD64YNq2+nR4086W1bWF4KZqBvnj6
         5tM3GfmAw14gMbim2ipNfBPFmub4IpdFr2pPPNr2ubv3jvfucY+iiRX+moSzNPlLXC2u
         ijIKuagpEyur5KUPli19piRsjFY89/n6b7LWPzwdRabZM7ZNERWkkZBbM2KKyP9ZZ5e7
         7ia6JHgLsr9aBqszgvlT0xzCdp87/yJ7uJR2ZHjRusLxxpX7rN7fYBeLK15W7OP9BAz3
         33M/V4uz9jU2bwOE4XpLb4hhqhctavKrvptvjnp8EOat6qRb7rv1/8wwpUVeVZhprj1S
         6H7g==
X-Gm-Message-State: APjAAAWQnsmGbVJnEkHKjh/3752QE0POCoDhLZR/FSKJ9pJYkIbomYXA
        pQhjqyJJszSEZXJHHUB4Rp++R03lLTIZ
X-Google-Smtp-Source: APXvYqzWUjmgAs0gWTsax0UACPwKiN2Y7zcwmRJ6s2bwdkhcpeunlwMy6aapGtHYdi90TFWX4H24ZE9m4Z/V
X-Received: by 2002:adf:ee03:: with SMTP id y3mr5915285wrn.5.1582910420967;
 Fri, 28 Feb 2020 09:20:20 -0800 (PST)
Date:   Fri, 28 Feb 2020 17:20:13 +0000
In-Reply-To: <20200228172015.44369-1-qperret@google.com>
Message-Id: <20200228172015.44369-2-qperret@google.com>
Mime-Version: 1.0
References: <20200228172015.44369-1-qperret@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v6 1/3] kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYMS
From:   Quentin Perret <qperret@google.com>
To:     masahiroy@kernel.org, nico@fluxnic.net
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        maennich@google.com, kernel-team@android.com, jeyu@kernel.org,
        hch@infradead.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_TRIM_UNUSED_KSYMS currently removes all unused exported symbols
from ksymtab. This works really well when using in-tree drivers, but
cannot be used in its current form if some of them are out-of-tree.

Indeed, even if the list of symbols required by out-of-tree drivers is
known at compile time, the only solution today to guarantee these don't
get trimmed is to set CONFIG_TRIM_UNUSED_KSYMS=n. This not only wastes
space, but also makes it difficult to control the ABI usable by vendor
modules in distribution kernels such as Android. Being able to control
the kernel ABI surface is particularly useful to ship a unique Generic
Kernel Image (GKI) for all vendors, which is a first step in the
direction of getting all vendors to contribute their code upstream.

As such, attempt to improve the situation by enabling users to specify a
symbol 'whitelist' at compile time. Any symbol specified in this
whitelist will be kept exported when CONFIG_TRIM_UNUSED_KSYMS is set,
even if it has no in-tree user. The whitelist is defined as a simple
text file, listing symbols, one per line.

Acked-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Tested-by: Matthias Maennich <maennich@google.com>
Reviewed-by: Matthias Maennich <maennich@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 init/Kconfig                | 13 +++++++++++++
 scripts/adjust_autoksyms.sh | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 20a6ac33761c..873256bdbea5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2208,6 +2208,19 @@ config TRIM_UNUSED_KSYMS
 
 	  If unsure, or if you need to build out-of-tree modules, say N.
 
+config UNUSED_KSYMS_WHITELIST
+	string "Whitelist of symbols to keep in ksymtab"
+	depends on TRIM_UNUSED_KSYMS
+	help
+	  By default, all unused exported symbols will be un-exported from the
+	  build when TRIM_UNUSED_KSYMS is selected.
+
+	  UNUSED_KSYMS_WHITELIST allows to whitelist symbols that must be kept
+	  exported at all times, even in absence of in-tree users. The value to
+	  set here is the path to a text file containing the list of symbols,
+	  one per line. The path can be absolute, or relative to the kernel
+	  source tree.
+
 endif # MODULES
 
 config MODULES_TREE_LOOKUP
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index a904bf1f5e67..212ba45595d3 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -38,6 +38,17 @@ esac
 # We need access to CONFIG_ symbols
 . include/config/auto.conf
 
+ksym_wl=/dev/null
+if [ -n "$CONFIG_UNUSED_KSYMS_WHITELIST" ]; then
+	# Use 'eval' to expand the whitelist path and check if it is relative
+	eval ksym_wl="$CONFIG_UNUSED_KSYMS_WHITELIST"
+	[ "${ksym_wl}" != "${ksym_wl#/}" ] || ksym_wl="$abs_srctree/$ksym_wl"
+	if [ ! -f "$ksym_wl" ] || [ ! -r "$ksym_wl" ]; then
+		echo "ERROR: '$ksym_wl' whitelist file not found" >&2
+		exit 1
+	fi
+fi
+
 # Generate a new ksym list file with symbols needed by the current
 # set of modules.
 cat > "$new_ksyms_file" << EOT
@@ -48,6 +59,7 @@ cat > "$new_ksyms_file" << EOT
 EOT
 sed 's/ko$/mod/' modules.order |
 xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
+cat - "$ksym_wl" |
 sort -u |
 sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"
 
-- 
2.25.1.481.gfbce0eb801-goog

