Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C5014FD9D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 15:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgBBOja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 09:39:30 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33120 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgBBOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 09:39:30 -0500
Received: by mail-vs1-f68.google.com with SMTP id n27so7352630vsa.0;
        Sun, 02 Feb 2020 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3Dg6x9hnD70y5KWc5Dl2R5pAeERtj8ATYaWnvKE23s=;
        b=Uj3RBFmff7CUg/JT7/qkMO1/Go8IME3xKzS0206G+MAG/MGh5yWGd9Rv1i5Vv9Jlx2
         WnB9pXZhcl8mRzk0o6Wbn0MDVYJpu9dgg6/TL+yni2fNUn1oMIDlp6JkYfDJKN77Z+RV
         /NRaJkxTSnGpigWW+eQtCUUxp+kc0ySTyut4D8TH0krIQfcrjppCZSgJ+CbGQiPmc59k
         WxymGpppwUH/uFFXBOMB5nsQpMiDaynKT+yJNNeHLc3uBJFhXAKWiIQZneBN/1hsbtoO
         Sl+uPEcpGOHILNrn6siLX42quB5zq59tO2DE7HCLuZAzNJfdLM6uvm7rItCcilb/vMaY
         0RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3Dg6x9hnD70y5KWc5Dl2R5pAeERtj8ATYaWnvKE23s=;
        b=aO1jM7PUzKU0r//S/4P6JFh3TQMrW66y5YwylZ5mmZBk4jZsvm0oV0KE+NMc6v19to
         tjOSItqWiHc6TJRsAoIcVxbt9Cf2F5JrnwPfRSKfrri+paUtjiRDIj4ZTYmFKXs2WF3+
         5jKIM3i7lCKBhtZK3SuMMuU+7DeEX24wFvkWy2YZsxUqVFI2zLM2ABs1d2IZJpUJlLKl
         wLaIDbV0J9CMRs72R/DqxR1u+KiM0Rt3rIe7LK1z732cjd918hyme93VzaIsYoNptXMn
         BBzZKgndVbQe5evNp2Bysnzqb4Xj/7NaXyaa7p1qJluNRagm10WmqKip7nj/nfw/q9Re
         T0yw==
X-Gm-Message-State: APjAAAXLcaegWFBUMju5jTgOZysVyxdIhnOHM+hPakNAka9IZmTk+n2u
        WGEObxZZWmoTwzVmIH0gC0fF5sFBBUCbml2zo2bxIZfx9u0=
X-Google-Smtp-Source: APXvYqw6zgyNgIA2W7l7G+72km62tYoznEG8yQuAPP40j+jTysNsnG/FBCpj6ZCZhRFETBUC23O1GURk7wjvrmianrw=
X-Received: by 2002:a67:10c1:: with SMTP id 184mr11097055vsq.76.1580654368977;
 Sun, 02 Feb 2020 06:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20200129105251.12466-1-stanley.chu@mediatek.com>
In-Reply-To: <20200129105251.12466-1-stanley.chu@mediatek.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sun, 2 Feb 2020 20:08:52 +0530
Message-ID: <CAGOxZ53r7O2PbOTXAs4y9diE_Hc-yj0Q-keHLp00HUwMzjbSag@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 0/4] MediaTek UFS vendor implemenation part III
 and Auto-Hibern8 fix
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>, asutoshd@codeaurora.org,
        Can Guo <cang@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        andy.teng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello Stanley

On Wed, Jan 29, 2020 at 4:24 PM Stanley Chu <stanley.chu@mediatek.com> wrote:
>
> Hi,
>
> This series provides MediaTek vendor implementations and some general fixes.
>
> - General fixes
>         - Fix Auto-Hibern8 error detection
>
> - MediaTek vendor implementations
>         - Ensure UniPro is powered on before every link startup
>         - Support linkoff state during suspend
>         - Gate reference clock for Auto-Hibern8 case
>
> v3 (Resend)
>         - Fix "Fixes" tag in patch "scsi: ufs: fix Auto-Hibern8 error detection" (Greg KH)
>
> v2 -> v3
>         - Squash below patches to a single patch (Bean Huo)
>                 - scsi: ufs: add ufshcd_is_auto_hibern8_enabled facility
>                 - scsi: ufs: fix auto-hibern8 error detection
>         - Add Fixes tag in patch "scsi: ufs: fix Auto-Hibern8 error detection" (Bean Huo)
>         - Rename VS_LINK_HIBER8 to VS_LINK_HIBERN8 in patch "scsi: ufs-mediatek: gate ref-clk during Auto-Hibern8"
>
> v1 -> v2
>         - Fix and refine commit messages.
>
> Stanley Chu (4):
>   scsi: ufs-mediatek: ensure UniPro is not powered down before linkup
>   scsi: ufs-mediatek: support linkoff state during suspend
>   scsi: ufs: fix Auto-Hibern8 error detection
>   scsi: ufs-mediatek: gate ref-clk during Auto-Hibern8
>
For this series, feel free to add
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Thanks

>  drivers/scsi/ufs/ufs-mediatek.c | 67 +++++++++++++++++++++------------
>  drivers/scsi/ufs/ufs-mediatek.h | 12 ++++++
>  drivers/scsi/ufs/ufshcd.c       |  3 +-
>  drivers/scsi/ufs/ufshcd.h       |  6 +++
>  4 files changed, 63 insertions(+), 25 deletions(-)
>
> --
> 2.18.0



-- 
Regards,
Alim
