Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19172182DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 11:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCLKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 06:34:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24541 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726302AbgCLKed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584009272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Elhehx58JjnpVasvGfpItQAGWL5MtskgGw42pHcHbh8=;
        b=MkoWJc5ocHikYfjf6Gclr3HcX2TOHfEXyoTtPKH2w47X5o60BdRg9y+gJyTOrnV62sImiL
        pKe9PFihso6C8fZpN8Joyewbmw2xgHG4sWiE8BTeAXI9zkdPI1iTd5qduYqf1jjiOkAQw1
        1BHWAlc0/ABR8+61DWDXdHejs1VP5Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-mZfkIStbNYSgFB-GvJ0d3g-1; Thu, 12 Mar 2020 06:34:30 -0400
X-MC-Unique: mZfkIStbNYSgFB-GvJ0d3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F178C8017CC;
        Thu, 12 Mar 2020 10:34:28 +0000 (UTC)
Received: from elisabeth (ovpn-200-18.brq.redhat.com [10.40.200.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 348FB272A5;
        Thu, 12 Mar 2020 10:34:23 +0000 (UTC)
Date:   Thu, 12 Mar 2020 11:34:16 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        daniel.baluta@gmail.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: rtw_mlme: Remove
 unnecessary conditions
Message-ID: <20200312113416.23d3db5c@elisabeth>
In-Reply-To: <61a6c3d7-6592-b57b-6466-995309302cc2@linux.microsoft.com>
References: <20200311135859.5626-1-shreeya.patel23498@gmail.com>
        <61a6c3d7-6592-b57b-6466-995309302cc2@linux.microsoft.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

On Wed, 11 Mar 2020 19:42:06 -0700
Lakshmi Ramasubramanian <nramas@linux.microsoft.com> wrote:

> On 3/11/2020 6:58 AM, Shreeya Patel wrote:
> 
> > Remove unnecessary if and else conditions since both are leading to the
> > initialization of "phtpriv->ampdu_enable" with the same value.
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>  
> 
> Stating this based on the patch descriptions I have seen.
> Others, please advise\correct me if I am wrong.
> 
> Patch description should state the problem first[1] and then describe 
> how that is fixed in the given patch.
> 
> For example:
> 
> In the function rtw_update_ht_cap(), phtpriv->ampdu_enable is set to the 
> same value in both if and else statements.
> 
> This patch removes this unnecessary if-else statement.

That's my general preference as well, but I can't find any point in the
"Describe your changes" section of submitting-patches.rst actually
defining the order. I wouldn't imply that from the sequence the steps
are presented in.

In case it's possible to say everything with a single statement as
Shreeya did here, though, I guess that becomes rather a linguistic
factor, and I personally prefer the concise version here.

-- 
Stefano

