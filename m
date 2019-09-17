Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7AB4BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 12:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfIQKPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 06:15:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727636AbfIQKPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:15:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A029AE7F;
        Tue, 17 Sep 2019 10:15:20 +0000 (UTC)
Date:   Tue, 17 Sep 2019 12:15:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Lucian Adrian Grijincu <lucian@fb.com>, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@fb.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3] mm: memory: fix /proc/meminfo reporting for
 MLOCK_ONFAULT
Message-ID: <20190917101519.GD1872@dhcp22.suse.cz>
References: <20190913211119.416168-1-lucian@fb.com>
 <20190916152619.vbi3chozlrzdiuqy@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916152619.vbi3chozlrzdiuqy@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-09-19 18:26:19, Kirill A. Shutemov wrote:
> On Fri, Sep 13, 2019 at 02:11:19PM -0700, Lucian Adrian Grijincu wrote:
> > As pages are faulted in MLOCK_ONFAULT correctly updates
> > /proc/self/smaps, but doesn't update /proc/meminfo's Mlocked field.
> 
> I don't think there's something wrong with this behaviour. It is okay to
> keep the page an evictable LRU list (and not account it to NR_MLOCKED).

evictable list is an implementation detail. Having an overview about an
amount of mlocked pages can be important. Lazy accounting makes this
more fuzzy and harder for admins to monitor.

Sure it is not a bug to panic about but it certainly makes life of poor
admins harder.

If there is a pathological THP behavior possible then we should look
into that as well.
-- 
Michal Hocko
SUSE Labs
