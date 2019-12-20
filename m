Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55D9127E43
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 15:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfLTOja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 09:39:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:39186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfLTOj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:39:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16D27ADFE;
        Fri, 20 Dec 2019 14:39:24 +0000 (UTC)
Date:   Fri, 20 Dec 2019 15:39:22 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] scsi: blacklist: add VMware ESXi cdrom - broken tray
 emulation
Message-ID: <20191220143922.GM4113@kitsune.suse.cz>
References: <20191217180840.9414-1-msuchanek@suse.de>
 <yq1bls6h9ir.fsf@oracle.com>
 <20191219143422.GJ4113@kitsune.suse.cz>
 <yq1pngjc2pr.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1pngjc2pr.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 06:31:12PM -0500, Martin K. Petersen wrote:
> 
> Michal,
> 
> >> Please don't introduce a blist flag to work around deficiencies in the
> >> matching interface. I suggest you tweak the matching functions so they
> >> handle a NULL vendor string correctly.
> >
> > I don't think that will work with the interface for dynamically adding
> > entries through sysfs.
> 
> Please make it work :)
> 
> There's nothing conceptually wrong with being able to do:
> 
>         echo ":Model:Flags" > /proc/scsi/device_info
> 
> We keep running into issues where the same device needs to be listed
> many times because it gets branded by different vendors.
> 
Is there any description of what the format is supposed to be?

From the current code it looks like comma separated list of blacklist
entries that may be optionally quoted in some way.

The quoting is basically ignored but it is not clear if the inidividual
entries are supposed to be quoted or the whole thing.

Thanks

Michal
