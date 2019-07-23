Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7996072312
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 01:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfGWXaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 19:30:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17344 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfGWXaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:30:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d37988a0000>; Tue, 23 Jul 2019 16:30:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jul 2019 16:30:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Jul 2019 16:30:20 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 23:30:20 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Jul 2019 23:30:20 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d37988b000b>; Tue, 23 Jul 2019 16:30:19 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 0/2] mm/hmm: more HMM clean up
Date:   Tue, 23 Jul 2019 16:30:14 -0700
Message-ID: <20190723233016.26403-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563924618; bh=FDbwFDSZuMyIknDuhtiS91edYJrPm1xbqLmLfcav/Qw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=dFlkIYFBEahjwsEE41Zja3tD83QFXyCZwYtuwUf3HBcIKWr/C8XVrbvjMIQm1+Lo0
         Vj9TsJdpNOTAuaK1b1PgiMTlip9kDy1Hfro5q2mEpL2opgUnegJ+1Fm/F6MF2PATXh
         Gd4P7ZaDfwpKawPOmovjf/1lrYBxgpvagSXMctDX0o22gStsuEe+M9kyU+x8hKXAqg
         ZJ4W7J3TKLOk1fnttYAcYFo9E0VkpNcMBwcb3tYKJfDKaYa+xUks4qBrTaaHRcUxac
         s1QP7P4RLQPRM52ylO0zWpcoLzP69Zz9JWkIk20IcPGb5KoSw3Lgd9zqvwWvb7mbg5
         uywZaQAcOHSBQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two more patches for things I found to clean up.
I assume this will go into Jason's tree since there will likely be
more HMM changes in this cycle.

Ralph Campbell (2):
  mm/hmm: a few more C style and comment clean ups
  mm/hmm: make full use of walk_page_range()

 mm/hmm.c | 231 +++++++++++++++++++++----------------------------------
 1 file changed, 86 insertions(+), 145 deletions(-)

--=20
2.20.1

