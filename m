Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9E10B28C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK0PkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 10:40:20 -0500
Received: from gentwo.org ([3.19.106.255]:39426 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfK0PkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:40:20 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id D60133EF16; Wed, 27 Nov 2019 15:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id D50ED3EC1C;
        Wed, 27 Nov 2019 15:40:19 +0000 (UTC)
Date:   Wed, 27 Nov 2019 15:40:19 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
In-Reply-To: <20191126165420.GL20912@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1911271535560.16935@www.lameter.com>
References: <20191126121901.GE20912@dhcp22.suse.cz> <alpine.DEB.2.21.1911261632030.9857@www.lameter.com> <20191126165420.GL20912@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019, Michal Hocko wrote:

> > I have no idea about what this is.
>
> It seems to be there since the initial merge. I suspect this is just
> following a generic sysfs rule that each file has to provide those
> events?

I have never heard of anyone using this.

> > There have been many people who
> > reworked the sysfs support and this has been the cause for a lot of
> > breakage over the years.
>
> Remember any specifics?

The sequencing of setup / teardown of sysfs entries has frequently been
a problem and that caused numerous issues with slab initialization as well
as kmem cache creation. Initially kmalloc DMA caches were created on
demand which caused some issues. Then there was the back and forth with
cache aliasing during kmem_cache_create() that caused another set of
instabilities.

> I am mostly interested in potential users. In other words I am thinking
> to suppress those events. There is already ke knob to control existence
> of memcg caches but I do not see anything like this for root caches.
>

I am not aware of any users but the deployments of Linux are so diverse
these days that I am not sure that there are no users.

