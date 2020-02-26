Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E911700B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgBZODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 09:03:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:33630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBZODT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:03:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 817D2AC54;
        Wed, 26 Feb 2020 14:03:17 +0000 (UTC)
Subject: Re: [PATCH 3/3] mm/vma: Make is_vma_temporary_stack() available for
 general use
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1582692658-3294-1-git-send-email-anshuman.khandual@arm.com>
 <1582692658-3294-4-git-send-email-anshuman.khandual@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <df8b59f9-ccf2-5a40-661e-2bf053b99dac@suse.cz>
Date:   Wed, 26 Feb 2020 15:03:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582692658-3294-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/20 5:50 AM, Anshuman Khandual wrote:
> Currently the declaration and definition for is_vma_temporary_stack() are
> scattered. Lets make is_vma_temporary_stack() helper available for general
> use and also drop the declaration from (include/linux/huge_mm.h) which is
> no longer required. This should not cause any functional change.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

The move made it plainly visible that the is_vma_* name differs from all the
other vma_is_* names. So this is a good chance to unify it?

Thanks,
Vlastimil
