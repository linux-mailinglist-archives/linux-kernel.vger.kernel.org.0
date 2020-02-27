Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29851711DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 09:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgB0IAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 03:00:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:39376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgB0IAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:00:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33DB9AD94;
        Thu, 27 Feb 2020 08:00:38 +0000 (UTC)
Subject: Re: [PATCH V2 1/3] mm/vma: Move VM_NO_KHUGEPAGED into generic header
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1582782965-3274-1-git-send-email-anshuman.khandual@arm.com>
 <1582782965-3274-2-git-send-email-anshuman.khandual@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <98d5f17f-c073-5f1f-7cef-5737f018786e@suse.cz>
Date:   Thu, 27 Feb 2020 09:00:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582782965-3274-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 6:56 AM, Anshuman Khandual wrote:
> Move VM_NO_KHUGEPAGED into generic header (include/linux/mm.h). This just
> makes sure that no VMA flag is scattered in individual function files any
> longer. While at this, fix an old comment which is no longer valid. This
> should not cause any functional change.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
