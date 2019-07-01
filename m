Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53966451B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfFNCE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 22:04:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfFNCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yturs7wMwtHOC03PX6twAD+J7FP490OG+euNcwoe3nc=; b=NLknHBA25G3wLh5qAJEElON3KV
        nTmMyZtZovH2iDbzaLkr6oN10lGmq95Zx3DGj4IhanQFBx8wrRVY1jen2UL145F4o1uAh0SzQTMiS
        4ex9DfLUQfFYjVyCHnWM2ne63Scs4dOEtSXYgUD/N1VRrWO6Rgngg7jpIV+MeHSWtMTyKwk4gOKLG
        vyhVCCOrRrBzUcdduO4qHxw6aDdVVQ8xR5SGKmq6QWquNe+Zlol+sC/4+DwEyJiiz5uh0FpDvu54g
        33kRkzVmn9BbVzPq9mX7JpQslIw3fYsM8Q93BOidA6wI8nfhWvCHZWP75HbmCg5UOZhKRPeQoPSg9
        q8WPwJ3A==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZr-0000E9-Dy; Fri, 14 Jun 2019 02:04:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002oC-Vd; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 11/14] scripts/get_abi.pl: fix parse issues with some files
Date:   Thu, 13 Jun 2019 23:04:17 -0300
Message-Id: <9e4d74e12ffd9287d3b9c99b148b166e031e5411.1560477540.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560477540.git.mchehab+samsung@kernel.org>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few files are failing to parse:

	Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
	Documentation/ABI/testing/sysfs-class-pktcdvd
	Documentation/ABI/testing/sysfs-bus-nfit

On all three files, the problem is that there is a ":" character
at the initial file description.

Improve the parse in order to handle those special cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index a2861fcec745..c3ccfdfc3a5d 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -87,7 +87,7 @@ sub parse_abi {
 					# New "tag" is actually part of
 					# description. Don't consider it a tag
 					$new_tag = "";
-				} else {
+				} elsif ($tag ne "") {
 					parse_error($file, $ln, "tag '$tag' is invalid", $_);
 				}
 			}
@@ -110,7 +110,7 @@ sub parse_abi {
 				next;
 			}
 
-			if ($new_tag) {
+			if ($tag ne "" && $new_tag) {
 				$tag = $new_tag;
 
 				if ($new_what) {
-- 
2.21.0

