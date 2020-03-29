Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768B6196F88
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgC2S6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 14:58:47 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17427 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgC2S6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585508318; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=W64XuA28vwCHedPy4g4Pr0NI1WZ4YdQHPSHR+moI4H/2lmmdJL9tc45/8/+Mj3NfKwTakYeTrhL5OZeEYlhgwjmZ5WhXPYqWJeNcL9AaOPlEwRgVPjz97/iGuLhj3nZMBi9zWQe5UmH7fK967HvRDa2mFUPSkB7hFiIPMU6oF20=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585508318; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Ejy7caoP8kv6vxqeRtJspkA+5HqgQGadRYqmDpvXAQc=; 
        b=Y3xIkzedvRFwz/AcuqLQCYxyS3Jsl1o7flORRWiEkIfbC1usHZXP7rTgCT0O1rdw6hRkvYjSWLqRRQTz+Rvot8YnMO1+iKSKxIpjT6RAhjUl0U3gF/f3J4tkecCdxTz/R++WcNjobn39yHycDqhHItrFJ4T4zyRI4s0TCAZSMhI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585508318;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Ejy7caoP8kv6vxqeRtJspkA+5HqgQGadRYqmDpvXAQc=;
        b=PTbM7Djsd3yEMs/MbAEUwn5DUQOZHR4lf91MuIsW5Od9/JvcPDulkS1/eNbm93pk
        r5zOQKN54zMLeVn2b8lZI6z01RwXzPUFzA8EfZOfbnZjQnIJ2sAo9I8Nnsq056xiYgT
        J54cDp558/8UlIdCkbH/45EPCEqvkvocQddZI4o8=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585508315518867.1055470302647; Sun, 29 Mar 2020 11:58:35 -0700 (PDT)
From:   Aiman Najjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Aiman Najjar <aiman.najjar@hurranet.com>,
        Joe Perches <joe@perches.com>
Message-ID: <cover.1585508171.git.aiman.najjar@hurranet.com>
Subject: [PATCH v3 0/5] staging: rtl8712: rtl871x_xmit.{c,h} code style improvements
Date:   Sun, 29 Mar 2020 14:57:42 -0400
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make several improvements to code style of rtl871x_xmit.c and rtl871x_xmit.=
h.

v1 -> v2: changes
* Break up single pach into patchset of small patches

v2 -> v3 changes:
* [PATCH 4/5]: Applied suggestions by Joe to improve overall code quality (=
thanks Joe!)


Aiman Najjar (5):
  staging: rtl8712: fix checkpatch long-line warning
  staging: rtl8712: fix long-line checkpatch warning
  staging: rtl8712: fix checkpatch warnings
  staging:rtl8712: code improvements to make_wlanhdr
  staging: rtl8712:fix multiline derefernce warnings

 drivers/staging/rtl8712/rtl871x_xmit.c | 158 ++++++++++++-------------
 drivers/staging/rtl8712/rtl871x_xmit.h |   2 +-
 2 files changed, 77 insertions(+), 83 deletions(-)

--=20
2.20.1


