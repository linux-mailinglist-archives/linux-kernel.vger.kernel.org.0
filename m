Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D325DE52
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 08:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGCG4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 02:56:44 -0400
Received: from foss.arm.com ([217.140.110.172]:39196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfGCG4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:56:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE7C02B;
        Tue,  2 Jul 2019 23:56:43 -0700 (PDT)
Received: from [10.162.42.95] (p8cg001049571a15.blr.arm.com [10.162.42.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02E933F718;
        Tue,  2 Jul 2019 23:58:34 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolate: change the prototype of
 undo_isolate_page_range()
To:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org
References: <1562075604-8979-1-git-send-email-kernelfans@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ada46116-9c87-86ce-9015-351700439ea3@arm.com>
Date:   Wed, 3 Jul 2019 12:27:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1562075604-8979-1-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2019 07:23 PM, Pingfan Liu wrote:
> undo_isolate_page_range() never fails, so no need to return value.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
