Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DC14D50B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfFTRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 13:25:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rO3bjQzjDxRANZzkYcNidTwoC5hB1Y63PVyrEzCq1+c=; b=qWGjF9nZfVmfvK40xnJaTBGHPu
        3hkxr6WoLtuXlPqyrAcAv16dQo9PNA0NOSbXAh7jdvpqsoDgA1AScMs10OKnGfjMjF1JKE7d2Inqi
        7A+702KeHiZEYgQlpoxZA93NHthspl/UYdQ4ymmgh/pupq8t1smDtSMXXQltURuXTsboHHurGdOYa
        8qCxwV9yB5pdZ+LglViQCV0v2InfBKJuu/68LkbtFYcvDbqXgKVZaVyrLDTO1kH7dbND4XVdNbYyU
        ZjrxfLyadtEMcG7ypzmJDeWbDfN1G3cLdfIgsKV5QTYeLsMAwHnDX727okkVLwQrf4AZn6QqQDIMS
        aKYdVLQA==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Rx-9X; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000DC-Ok; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 09/22] scripts/get_abi.pl: fix parse issues with some files
Date:   Thu, 20 Jun 2019 14:23:01 -0300
Message-Id: <485e3e80bbddc4e144bc1d110f980ace092c5e1c.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
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
index 7d454e359d25..116f0c33c16d 100755
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

