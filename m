Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8282CBD7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 07:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633949AbfIYFWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 01:22:03 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44612 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411744AbfIYFWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 01:22:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id u187so1538445ywa.11;
        Tue, 24 Sep 2019 22:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppXbKxF8auD4W/LlJIMC/lZP1qG5Ejh31x7zaeM9uKI=;
        b=VPIe039+m7AxYoWqVDyLQacMNCCJkzhvGzGInpu/h+mEDw5QI1Ybckk0zCmj3ckV35
         syacAWEMul7XpXh/UDaAu0WCXTYfAtVbSE75noobXexM88nKMk4I4gkYPoYvPjRmOsyY
         6Rx9JZU/vZTMPrKlqxLOmGKK8Dkt8ToQt9baygQ7/UdaGXr9eeNLEr8f7fE12NUhLdfc
         8tWNxSRIMsJuPlZJ975j2vcagUvezf89XGZcCAl1Kghv6razO1ebfPlge1IYUOQdVQMD
         dAgUInd21o4TKID4jrVlg9aILmgbq6fwtNPn3WnZSO7NKcHyg9WcTTTFASLIJcpkhloF
         HbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppXbKxF8auD4W/LlJIMC/lZP1qG5Ejh31x7zaeM9uKI=;
        b=Icl7wl+w2sa3mI+u6eDjc1YrNhkcXfdyc5DOScEnHsxDVAQUzeHTgsF3KdaFTrdPb+
         h72gGATIM/7MWdzl4mjVSzP8rDb3DLb3RXu4dg0o7OOtg5f4x85m/fwqmg1om1w26XvN
         wAS7I/8/2zaoF5JulxwNqir7+xjh+3ppvEb0zdrMCVQ+jCREnuLPONX+lKfUAUCUr+RF
         3ZKQcffsiaLmKPjf8nsyIIz2kKHphKU20atRrDSPVLn874vGGZNxp8RwHL2gIRmjg0zh
         VoEYbsg0+Coww3jjpX/d3ucsQuyDSdCOmw5tvlvKVtTrDjkROzqQkkwpHT1CK/4jQRwq
         KrCA==
X-Gm-Message-State: APjAAAVzzC9SESjbPrQCxL8W42BoMES0PqQntjDKPPxUVnB8ahJFnXgZ
        q6nOEkpkNSF1xROdy3sPChjwMeSIiH+kCiO9+qY=
X-Google-Smtp-Source: APXvYqxDgEimpwXaH1E402H5Z46G2msOuTrc/jDB2nazCZx0ghGZJr17vfvd1a8bPcXQ17ZTZ6N4OUHGrYbuPrNQevs=
X-Received: by 2002:a81:3c4b:: with SMTP id j72mr4400502ywa.379.1569388921979;
 Tue, 24 Sep 2019 22:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <1569376448-53998-1-git-send-email-chengzhihao1@huawei.com>
 <20190925030550.GA9913@magnolia> <20190925031733.GB9913@magnolia> <46aa2daf-4c4a-ea74-2300-bb32fdfbdbcc@huawei.com>
In-Reply-To: <46aa2daf-4c4a-ea74-2300-bb32fdfbdbcc@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Sep 2019 08:21:50 +0300
Message-ID: <CAOQ4uxgmCy+VyNr28UczWR3wCLdD3HN5qDk6XwBdsB_2sn0WAQ@mail.gmail.com>
Subject: Re: [PATCH xfstests v2] overlay: Enable character device to be the
 base fs partition
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eryu Guan <guaneryu@gmail.com>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
        Eric Biggers <ebiggers@google.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        fstests <fstests@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 6:27 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> There are indeed many '-b' options in xfstests. I only confirmed the line of overlay test. Other -b test options I need to reconfirm later.
>

FWIW, I eyeballed blockdev related overlayfs common code bits
and all I found out of order was:

@@ -3100,7 +3100,7 @@ _require_scratch_shutdown()
                        # SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
                        # will be null, so check OVL_BASE_SCRATCH_DEV before
                        # running shutdown to avoid shutting down base
fs accidently.
-                       _notrun "$SCRATCH_DEV is not a block device"
+                       _notrun "this test requires a valid
\$OVL_BASE_SCRATCH_DEV as ovl base fs"
                else
                        src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
                        || _notrun "Underlying filesystem does not
support shutdown"


Zhihaho,

That's all I meant in the nit.
The v1 commit message was perfectly fine, there was no need to change it at all.

Thanks,
Amir.
