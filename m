Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F071359CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgAINMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 08:12:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728974AbgAINMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578575556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=to2tC83cIN6vDKqhn+LssLPUECktszP/zdsC8v7PRMA=;
        b=Z2mECv0SnpxSKesECoVEIAXiW8xxHE/xu2WlxqAFTemsFxUsEy2vGkQIBDY9pEfuAFP2AI
        wNbl+KFVnPlsA1MzX3KuwKzwA8/WrgYrRtLrWKhazCfcnKGAANRwho0Wp/mFbyoO8wOJFL
        /8GSoluzlP3f8GuOt1LNJPaVi7q8enY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-XZIIqOGfNbKz-WjSOQcfLQ-1; Thu, 09 Jan 2020 08:12:33 -0500
X-MC-Unique: XZIIqOGfNbKz-WjSOQcfLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DECC801E72;
        Thu,  9 Jan 2020 13:12:31 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C10365C541;
        Thu,  9 Jan 2020 13:12:27 +0000 (UTC)
Message-ID: <cc8dddbcad70453efad665dc19787803ec48fdd6.camel@redhat.com>
Subject: Re: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "hch@lst.de" <hch@lst.de>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>
Date:   Thu, 09 Jan 2020 08:12:27 -0500
In-Reply-To: <yq1k161xq1f.fsf@oracle.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-5-sblbir@amazon.com>
         <BYAPR04MB57490FFCC025A88F4D97D40A86220@BYAPR04MB5749.namprd04.prod.outlook.com>
         <1b88bedc6d5435fa7154f3356fa3f1a3e6888ded.camel@amazon.com>
         <20200108150447.GC10975@lst.de> <yq1k161xq1f.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-08 at 22:33 -0500, Martin K. Petersen wrote:
> Christoph,
> 
> > > The expected behaviour is not clear, but the functionality is not
> > > broken, user space should be able to deal with a resize event where
> > > the previous capacity == new capacity IMHO.
> > 
> > I think it makes sense to not bother with a notification unless there
> > is an actual change.
> 
> I agree.
> 

Yes, absolutely.

