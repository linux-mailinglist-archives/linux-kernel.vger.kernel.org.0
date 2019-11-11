Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 933E4F76C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfKKOnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 09:43:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:49390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfKKOn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:43:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CD1CB234;
        Mon, 11 Nov 2019 14:43:25 +0000 (UTC)
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 0/3] xen/mcelog: assorted adjustments
Message-ID: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
Date:   Mon, 11 Nov 2019 15:43:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 1st change is simple cleanup, noticed while preparing for the
2nd patch, which presents the consumer of the interface extension
proposed in
https://lists.xenproject.org/archives/html/xen-devel/2019-11/msg00377.html.
The 3rd patch is sort of optional, considering that 32-bit Xen
support is slated to be phased out of the kernel.

1: drop __MC_MSR_MCGCAP
2: add PPIN to record when available
3: also allow building for 32-bit kernels

Jan
