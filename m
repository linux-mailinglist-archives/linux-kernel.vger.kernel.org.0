Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD07775FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 09:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGZH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 03:26:41 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:49221 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbfGZH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:26:41 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 961401C32A8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:26:39 +0100 (IST)
Received: (qmail 14945 invoked from network); 26 Jul 2019 07:26:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.7])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jul 2019 07:26:39 -0000
Date:   Fri, 26 Jul 2019 08:26:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] make "order" unsigned int
Message-ID: <20190726072637.GC2739@techsingularity.net>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 02:42:43AM +0800, Pengfei Li wrote:
> Objective
> ----
> The motivation for this series of patches is use unsigned int for
> "order" in compaction.c, just like in other memory subsystems.
> 

Why? The series is relatively subtle in parts, particularly patch 5.
There have been places where by it was important for order to be able to
go negative due to loop exit conditions. If there was a gain from this
or it was a cleanup in the context of another major body of work, I
could understand the justification but that does not appear to be the
case here.

-- 
Mel Gorman
SUSE Labs
