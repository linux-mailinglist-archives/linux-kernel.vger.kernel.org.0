Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3048BACFD9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfIHQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 12:51:35 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:35115 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfIHQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:51:34 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 94489214; Sun,  8 Sep 2019 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1567961491;
        bh=mF+4NLAhuyJUGqzq9vSqZm83S4VIa0cpRhn2ECd2y4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3OMR4q61kLV0E7oGS9ZGieXIIxu3qYyIlhFWo3OXmO73+qb8cGqTR96bm8K/WYTM
         aV7BbUA/n4mid/lYQJi+YJgrO8o4tTf/b2Te5FUiS6UVhNfoapq8c9cInhhIoBlPVB
         QdevGiXPsFeODOkwTHoH8Hn3kw3jI5agSyoDzCt7RxbmCFHTQlVgPMwQfsC7VT1DNV
         zp9QxVGaUsUsL1m3EnT1Oz+yeD1NOFnzIADxeF5E5UnY8j/VuCQBxz7qGe3A5AvGey
         uO79kDLHzWuyXCacbj3Z8sETEafbUYnKXY3G+xT8uVa35wSUeFv0t5+Hh1XEsN+H26
         Q1MeawsruR0dA==
Date:   Sun, 8 Sep 2019 16:51:31 +0000
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: exfat: add millisecond support
Message-ID: <20190908165131.GC7664@valentin-vidic.from.hr>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
 <20190908161015.26000-3-vvidic@valentin-vidic.from.hr>
 <20190908164040.GA8362@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908164040.GA8362@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 05:40:40PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Sep 08, 2019 at 04:10:15PM +0000, Valentin Vidic wrote:
> >  void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
> >  			u8 mode)
> >  {
> > +	u8 ms;
> >  	u16 t, d;
> >  	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
> >  
> >  	t = (tp->hour << 11) | (tp->min << 5) | (tp->sec >> 1);
> >  	d = (tp->year <<  9) | (tp->mon << 5) |  tp->day;
> >  
> > +	ms = tp->millisec;
> > +	if (tp->sec & 1) {
> > +		ms += 1000;
> > +	}
> 
> checkpatch didn't complain about this { } not being needed?
> 
> Same in other parts of this patch, please fix up.

No warnings from checkpatch here, will update the code.

-- 
Valentin
