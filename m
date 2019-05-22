Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61968266BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfEVPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 11:12:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38560 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfEVPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:12:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id u199so1876435oie.5;
        Wed, 22 May 2019 08:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvZ/Z9P3tq4Qk/f3lvJYbii/kSuP8i21CYwYXU54vt4=;
        b=l+FvUDsYoeABexJD/pugCeI/SomugXQ6pFWu7PJD+pKsgbm+oVV8gFms+20EZsqinm
         kOmN2uMkqUmNh1PmSy9gyQrwNkf3SFjlMZegcP7JKtS+V58Wl7cW/hUKP/j1vVVuNzh/
         8wL6Uoru7qdhOxKuFaOXYtgJF1no/Be1MGg5vwdjMjmNlBTZItGSf8DPVNhuHFmDkZK5
         InITJjD2Kn6JwrH2xHXoM4PQxr6+1a92vHdR9QenAtEuMVp5fyVL8X/vOTEmGz80bRM2
         DgVemTLatdyuMXFpwmiLxGdczRcsLjsD+oJaovRKGAaxsfDJcNA8GCwzdvSUAJnmvyqy
         hCaA==
X-Gm-Message-State: APjAAAWmb/O9ygtP8k+BmVFuLK1igSqZnQv0bx4gjG4E9qcVqGj/Kz4U
        TNZYw35jxFjg1CMwyNf/zrCrsOU=
X-Google-Smtp-Source: APXvYqzB/u8EsswyyPjrl0040B6L99NyH8CWlM34/gU5VUFzx3TvVGAVYjD5VwhDfXQnSDcmbQsASA==
X-Received: by 2002:aca:5ed7:: with SMTP id s206mr7282343oib.122.1558537960561;
        Wed, 22 May 2019 08:12:40 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k83sm321026oia.10.2019.05.22.08.12.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 08:12:39 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH] checkpatch.pl: Update DT vendor prefix check
Date:   Wed, 22 May 2019 10:12:38 -0500
Message-Id: <20190522151238.25176-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 8122de54602e ("dt-bindings: Convert vendor prefixes to
json-schema"), vendor-prefixes.txt has been converted to a DT schema.
Update the checkpatch.pl DT check to extract vendor prefixes from the new
vendor-prefixes.yaml file.

Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bb28b178d929..073051a4471b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3027,7 +3027,7 @@ sub process {
 			my @compats = $rawline =~ /\"([a-zA-Z0-9\-\,\.\+_]+)\"/g;
 
 			my $dt_path = $root . "/Documentation/devicetree/bindings/";
-			my $vp_file = $dt_path . "vendor-prefixes.txt";
+			my $vp_file = $dt_path . "vendor-prefixes.yaml";
 
 			foreach my $compat (@compats) {
 				my $compat2 = $compat;
@@ -3042,7 +3042,7 @@ sub process {
 
 				next if $compat !~ /^([a-zA-Z0-9\-]+)\,/;
 				my $vendor = $1;
-				`grep -Eq "^$vendor\\b" $vp_file`;
+				`grep -oE "\\"\\^[a-zA-Z0-9]+" $vp_file | grep -q "$vendor"`;
 				if ( $? >> 8 ) {
 					WARN("UNDOCUMENTED_DT_STRING",
 					     "DT compatible string vendor \"$vendor\" appears un-documented -- check $vp_file\n" . $herecurr);
-- 
2.20.1

