Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E088F1264DD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 15:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLSOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 09:34:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:43806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfLSOeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:34:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 35E88AD3B;
        Thu, 19 Dec 2019 14:34:24 +0000 (UTC)
Date:   Thu, 19 Dec 2019 15:34:22 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] scsi: blacklist: add VMware ESXi cdrom - broken tray
 emulation
Message-ID: <20191219143422.GJ4113@kitsune.suse.cz>
References: <20191217180840.9414-1-msuchanek@suse.de>
 <yq1bls6h9ir.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1bls6h9ir.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 05:28:28PM -0500, Martin K. Petersen wrote:
> 
> Michal,
> 
> > +	{"VMware", "VMware", NULL, BLIST_NO_MATCH_VENDOR | BLIST_NO_TRAY},
> 
> Please don't introduce a blist flag to work around deficiencies in the
> matching interface. I suggest you tweak the matching functions so they
> handle a NULL vendor string correctly.

I don't think that will work with the interface for dynamically adding
entries through sysfs.

Thanks

Michal
