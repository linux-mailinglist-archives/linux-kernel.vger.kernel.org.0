Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2355E15CAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 20:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgBMTM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 14:12:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727652AbgBMTM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581621178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3pLLVLig1uc97lbYVaMiWyMB8bq9fPfRpEXIp2spies=;
        b=VvWjEXnOEehlLAePfeYV3Bg+L9PXMI/cHeeoGp3AxX89eA92iqRr887PJ+4yGmWC4f7F3n
        ewhGpC84H0ioi7fOFhjWqY9ddfSTcPjNDGQHVDRMBc064/zFJxg1Mqhi1p0v1t6unqSGAL
        JYGQQQHYB+MoLImuDDrlVEU9/08Jzf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363--OFJ6Y_HN7GijxJy3P8bng-1; Thu, 13 Feb 2020 14:12:53 -0500
X-MC-Unique: -OFJ6Y_HN7GijxJy3P8bng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8270E80259A;
        Thu, 13 Feb 2020 19:12:52 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D634F5C13E;
        Thu, 13 Feb 2020 19:12:51 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/4] libnvdimm/region: Introduce NDD_LABELING
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
        <158155491425.3343782.10431348498314981347.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 13 Feb 2020 14:12:50 -0500
In-Reply-To: <158155491425.3343782.10431348498314981347.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Wed, 12 Feb 2020 16:48:34 -0800")
Message-ID: <x49sgje5mj1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> @@ -312,8 +312,9 @@ static ssize_t flags_show(struct device *dev,
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  
> -	return sprintf(buf, "%s%s\n",
> +	return sprintf(buf, "%s%s%s\n",
>  			test_bit(NDD_ALIASING, &nvdimm->flags) ? "alias " : "",
> +			test_bit(NDD_LABELING, &nvdimm->flags) ? "label" : "",
                                                                       ^

Missing a space.

The rest looks sane.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

