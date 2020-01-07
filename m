Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFBA1334FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 22:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgAGViA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 16:38:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28479 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727299AbgAGVhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578433074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSFxCL3k8Q6kQpuVjvodBV8GghU6vTCrTI5PKdnHV9s=;
        b=Wt5a7oKNSeQ7q2NZXLSWyWmlmQcm9qS9iiBWIufgGNPPUklqnugcdqpILQOpurTLGB5I7h
        /WYDZhj1ZrVFhCCCbfD2Z2E4lkTEUzNeL4lMTNmsvRb59oHAk9iZknos9SI5AyETIoPVBz
        3EdNYNosLvVRdC9uPzUWzyHGy0AF3Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-fmmXZbPlOemJuWh2TJdqVw-1; Tue, 07 Jan 2020 16:37:49 -0500
X-MC-Unique: fmmXZbPlOemJuWh2TJdqVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3463107ACC7;
        Tue,  7 Jan 2020 21:37:47 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 455638208E;
        Tue,  7 Jan 2020 21:37:44 +0000 (UTC)
Message-ID: <1eb9d796f81fffbb0bfe90bff8460bcda34cb04d.camel@redhat.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, ssomesh@amazon.com,
        Balbir Singh <sblbir@amazon.com>, hch@lst.de
Date:   Tue, 07 Jan 2020 16:37:43 -0500
In-Reply-To: <yq1y2uj283m.fsf@oracle.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
         <1578369479.3251.31.camel@linux.ibm.com> <yq1y2uj283m.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-06 at 23:39 -0500, Martin K. Petersen wrote:
> James,
> 
> > > We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
> > > capacity changes. However, this event does not automatically cause
> > > revalidation.
> > 
> > Which I seem to remember was a deliberate choice: some change
> > capacities occur because the path goes passive and default values get
> > installed.
> 
> Yep, it's very tricky territory.
> 

Yes, there are some storage arrays that refuse a READ CAPACITY
command in certain ALUA states so you can't get the new capacity anyway.

It might be nice to improve this, though, there are some cases now where
we set the capacity to zero when we revalidate and can't get the value.

-Ewan



