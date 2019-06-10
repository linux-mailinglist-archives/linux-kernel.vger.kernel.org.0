Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057D53BF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 00:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390422AbfFJWwk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jun 2019 18:52:40 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:42319 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390301AbfFJWwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:52:40 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x5AMqLnn024430
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jun 2019 07:52:21 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5AMqL6q016179;
        Tue, 11 Jun 2019 07:52:21 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5AMpo63002979;
        Tue, 11 Jun 2019 07:52:21 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-5829201; Tue, 11 Jun 2019 07:51:34 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0319.002; Tue,
 11 Jun 2019 07:51:33 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: soft-offline: return -EBUSY if
 set_hwpoison_free_buddy_page() fails
Thread-Topic: [PATCH v2 1/2] mm: soft-offline: return -EBUSY if
 set_hwpoison_free_buddy_page() fails
Thread-Index: AQHVH2UNBW9Lhf3e5UinMjf59GXrMKaUzwKAgAAZdgA=
Date:   Mon, 10 Jun 2019 22:51:33 +0000
Message-ID: <20190610225140.GA30991@hori.linux.bs1.fc.nec.co.jp>
References: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1560154686-18497-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20190610142033.6096a8ec73d4bf40b2612fb5@linux-foundation.org>
In-Reply-To: <20190610142033.6096a8ec73d4bf40b2612fb5@linux-foundation.org>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <03697C5541B2D04CB700AC95BD5D6F50@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 02:20:33PM -0700, Andrew Morton wrote:
> On Mon, 10 Jun 2019 17:18:05 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:
> 
> > The pass/fail of soft offline should be judged by checking whether the
> > raw error page was finally contained or not (i.e. the result of
> > set_hwpoison_free_buddy_page()), but current code do not work like that.
> > So this patch is suggesting to fix it.
> 
> Please describe the user-visible runtime effects of this change?

Sorry, could you replace the description as follows (I inserted one sentence)?

    The pass/fail of soft offline should be judged by checking whether the
    raw error page was finally contained or not (i.e. the result of
    set_hwpoison_free_buddy_page()), but current code do not work like that.
    It might lead us to misjudge the test result when
    set_hwpoison_free_buddy_page() fails.  So this patch is suggesting to
    fix it.

Thanks,
Naoya Horiguchi
