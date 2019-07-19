Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAD6E471
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfGSKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 06:42:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfGSKm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:42:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E3DAAE6D;
        Fri, 19 Jul 2019 10:42:27 +0000 (UTC)
Subject: Re: incoming
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190718155613.546f9056bbb57f486ab64307@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <809b06d4-c4e9-b74b-c9a5-f693b860c5ec@suse.cz>
Date:   Fri, 19 Jul 2019 12:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718155613.546f9056bbb57f486ab64307@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/19 12:56 AM, Andrew Morton wrote:
> 
> The rest of MM and a kernel-wide procfs cleanup.
> 
> 
> 
> Summary of the more significant patches:

Thanks for that!

Perhaps now it would be nice if this went also to linux-mm and lkml, as
mm-commits is sort of hidden.

Vlastimil
