Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1651E021F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfJVKda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 06:33:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:36092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730197AbfJVKda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:33:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76520B34A;
        Tue, 22 Oct 2019 10:33:28 +0000 (UTC)
Date:   Tue, 22 Oct 2019 12:33:25 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191022103319.GA21736@linux>
References: <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz>
 <20191021125842.GA11330@linux>
 <20191021154158.GV9379@dhcp22.suse.cz>
 <20191022074615.GA19060@linux>
 <20191022082611.GD9379@dhcp22.suse.cz>
 <20191022083505.GA19708@linux>
 <20191022092256.GH9379@dhcp22.suse.cz>
 <20191022095852.GB20429@linux>
 <20191022102457.GJ9379@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022102457.GJ9379@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:24:57PM +0200, Michal Hocko wrote:
> Yes, that makes a perfect sense. What I am saying that the migration
> (aka trying to recover) is the main and only difference. The soft
> offline should poison page tables when not able to migrate as well
> IIUC.

Yeah, I see your point.
I do not really why soft-offline strived so much to left the page
untouched unless it was able to content the problem.

Note that if we start now to poison pages even if we could not 
content them (in soft-offline mode), that is a big and visible user
change.

Not saying it is wrong, but something to consider.

Anyway, I would like to put that aside as a follow-up
rework after this one, as this one already changes quite
some things.

-- 
Oscar Salvador
SUSE L3
