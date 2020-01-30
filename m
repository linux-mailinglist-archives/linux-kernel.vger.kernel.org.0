Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44FA14D556
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 04:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgA3DJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 22:09:25 -0500
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:53563 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726719AbgA3DJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 22:09:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0B627100E7B42;
        Thu, 30 Jan 2020 03:09:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2892:2894:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3871:3872:4250:4321:4605:5007:6119:7875:7903:8603:8957:9010:10004:10400:11232:11657:11658:11914:12043:12048:12297:12555:12740:12760:12895:12986:13095:13439:14096:14097:14181:14659:14721:21080:21212:21220:21433:21451:21627:30054:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bell00_6ef0b4c9d2c14
X-Filterd-Recvd-Size: 3866
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Jan 2020 03:09:22 +0000 (UTC)
Message-ID: <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
Subject: Re: [PATCH] security/integrity: Include __func__ in messages for
 easier debug
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, jmorris@namei.org,
        serge@hallyn.com, mpe@ellerman.id.au, zohar@linux.ibm.com,
        erichte@linux.ibm.com, nayna@linux.ibm.com, yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 Jan 2020 19:08:15 -0800
In-Reply-To: <20200130020129.15328-1-skhan@linuxfoundation.org>
References: <20200130020129.15328-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-29 at 19:01 -0700, Shuah Khan wrote:
> Change messages to messages to make it easier to debug. The following
> error message isn't informative enough to figure out what failed.
> Change messages to include function information.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
>  security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
>  2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c

perhaps instead add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
so all the pr_<level> logging is more specific.

This would prefix all pr_<level> output with "integrity: "

3integrity: Couldn't get size: 0x%lx
3integrity: Error reading db var: 0x%lx
3integrity: MODSIGN: Couldn't get UEFI db list
3integrity: Couldn't parse db signatures: %d
6integrity: Couldn't get UEFI MokListRT
3integrity: Couldn't parse MokListRT signatures: %d
6integrity: Couldn't get UEFI dbx list
3integrity: Couldn't parse dbx signatures: %d

5integrity: Platform Keyring initialized
6integrity: Error adding keys to platform keyring %s

---
 security/integrity/platform_certs/load_powerpc.c     | 3 +++
 security/integrity/platform_certs/load_uefi.c        | 2 ++
 security/integrity/platform_certs/platform_keyring.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index a2900c..5cfbd0 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -5,6 +5,9 @@
  *
  *      - loads keys and hashes stored and controlled by the firmware.
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 111898a..480450a 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
index 7646e35..9bd2846 100644
--- a/security/integrity/platform_certs/platform_keyring.c
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -6,6 +6,8 @@
  * Author(s): Nayna Jain <nayna@linux.ibm.com>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>

