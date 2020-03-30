Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC4F197190
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 03:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgC3BFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 21:05:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36945 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727549AbgC3BFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585530324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDJV5yf5sqTq7BBH6Thf8EcLPKuxR3i7R8Gj+S8lYwI=;
        b=RFapGFgGdtXRqKuNEKrVxC43TY/bqyMxUxRVYWk0lN+se45aI5iz2swjf+UOcItRgW2hUX
        CAZcZ3AlYDqvaqO21eZCFMi0Pxk+tvhxbuHKVuIRaL1WnNHkIMETP99ATlkX3JwGypm/PF
        HC3JImakn/B1IKir7FzD0b1arCmWlVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-0nIyAOliOYObPc1tDlI5xA-1; Sun, 29 Mar 2020 21:05:19 -0400
X-MC-Unique: 0nIyAOliOYObPc1tDlI5xA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8181477;
        Mon, 30 Mar 2020 01:05:17 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CA7597AF7;
        Mon, 30 Mar 2020 01:05:13 +0000 (UTC)
Date:   Mon, 30 Mar 2020 03:05:09 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, Larry.Finger@lwfinger.net
Subject: Re: [Outreachy kernel] [PATCH v2] Staging: rtl8188eu: hal: Add
 space around operators
Message-ID: <20200330030509.59cc78e7@elisabeth>
In-Reply-To: <20200325160142.3698-1-shreeya.patel23498@gmail.com>
References: <20200325160142.3698-1-shreeya.patel23498@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 21:31:42 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Add space around operators for improving the code
> readability.
> Reported by checkpatch.pl
> 
> git diff -w shows no difference.
> diff of the .o files before and after the changes shows no difference.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

