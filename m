Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2C1691F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 19:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfEGR0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 13:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEGR0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:26:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 743FB36887;
        Tue,  7 May 2019 17:26:00 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D766E171AD;
        Tue,  7 May 2019 17:25:59 +0000 (UTC)
Date:   Tue, 7 May 2019 11:25:59 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Greg Kurz <groug@kaod.org>
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-pci/nvlink2: Fix potential VMA leak
Message-ID: <20190507112559.2022645c@x1.home>
In-Reply-To: <20190507090145.4be12c82@bahia.lan>
References: <155568823785.601037.2151744205292679252.stgit@bahia.lan>
        <20190506155845.70f3b01d@x1.home>
        <20190507014915.GA10274@tungsten.ozlabs.ibm.com>
        <20190507090145.4be12c82@bahia.lan>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 07 May 2019 17:26:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019 09:01:45 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Tue, 7 May 2019 11:52:44 +1000
> Sam Bobroff <sbobroff@linux.ibm.com> wrote:
> 
> > On Mon, May 06, 2019 at 03:58:45PM -0600, Alex Williamson wrote:  
> > > On Fri, 19 Apr 2019 17:37:17 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > >     
> > > > If vfio_pci_register_dev_region() fails then we should rollback
> > > > previous changes, ie. unmap the ATSD registers.
> > > > 
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---    
> > > 
> > > Applied to vfio next branch for v5.2 with Alexey's R-b.  Thanks!
> > > 
> > > Alex    
> > 
> > Should this have a fixes tag? e.g.:
> > Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> >   
> 
> Oops... you're right.
> 
> Alex, can you add the above tag ?

Added.  Thanks,

Alex
