Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64B183B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 22:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgCLVQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 17:16:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46899 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLVQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:16:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so9368903wrw.13;
        Thu, 12 Mar 2020 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoRMJHL0lSK4lVACsrhjsoeS3m+0TZ7d70msLMcwZXM=;
        b=f0enO67akTjopRTWqxr9OXsYNFl1y1vda7MC0cyMvXeSTXMulMQzzWpxOQmZjXWkw/
         SvQ/PejNSH6KWtM48vIFSosY4KrvgVui3/hs1MtMZK/HlyubRuWEjmiZJzQ9X5Veo63V
         zk9SANcBaya12IWkiMc0LXsLdHDe7O4M5/AeuKBfxJSZVQapD6ICkpOOyJTTloE5yeb2
         7EY/J+nz6/VvDma5jFofVyrjRXvvMB5E65OmQAz6O4Ff/t3skTaLu8WDDUFn7q/1hE4V
         8EabQ+PC6HPcBCbEmZTwnH9kN1XdgejpEkOhFgZ7Qi9IoE1vxx1W44F5M0HvoHH6xxe4
         yBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoRMJHL0lSK4lVACsrhjsoeS3m+0TZ7d70msLMcwZXM=;
        b=AS/kmQ4HoeUSOgwAbIXuRmxKr+WtY0T1Dw5MYzYj613FHx6kcOIpUP7HBGi+6UlK95
         7KBl9o+9mbz0TLcSaiOrzdrJmmBHGrCo0lJ1w9PJ23c2r+1JxuVWgAcO7M54x+JtLmDa
         NM29kI3lUeAF7niMnA1P4ZquCWwR1IhmGk7HuaiHvJyqZkUH+fYpSOADdKmcKKnk8oTc
         1PDA14CylzaaNmZq38C+mxMbDCDHNStIOyu0QC35PaBXSCjSw0qLPGjQaNcFOwvr+5V8
         5dpuZikx+j5hPir4TgXYWT4EGdsQtDlzJM+psk+zbUEHriWDMk2eACRYOJO89WaoP0+N
         BnwA==
X-Gm-Message-State: ANhLgQ045GjZTzx4WNdX9c9ET6yl+NN+tcHM1/CbbwboDgBSWYdJ37Fa
        BlBwV0/tbomougoHpk3zwGsOHexuzSUZe9vAsxA=
X-Google-Smtp-Source: ADFU+vsEHGHrexnu9ajEOuztTkNdb4fV9udOvVmtFGq+NVjQuWlQ8XfZ3prQYZRqoV0QXCYAc0BynI/yrz09GLW65GA=
X-Received: by 2002:a5d:61c9:: with SMTP id q9mr13587880wrv.164.1584047781214;
 Thu, 12 Mar 2020 14:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
 <20200210095817.13226-5-daniel.baluta@oss.nxp.com> <20200219221422.GA32379@bogus>
In-Reply-To: <20200219221422.GA32379@bogus>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 12 Mar 2020 23:16:09 +0200
Message-ID: <CAEnQRZA6PEhfO0y5xWvAJZcK784n_2FXgDgYAfdDFUa2Osj7XQ@mail.gmail.com>
Subject: Re: [RESEND 4/4] dt-bindings: dsp: fsl: Add fsl,imx8qm-dsp entry
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:15 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 10 Feb 2020 11:58:17 +0200, Daniel Baluta wrote:
> > From: Paul Olaru <paul.olaru@nxp.com>
> >
> > This is the same DSP from the hardware point of view, but it gets a
> > different compatible string due to usage in a separate platform.
> >
> > Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >  Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Hi Rob,

Who should take this patch? Mark applied first 3 patches in the series.
