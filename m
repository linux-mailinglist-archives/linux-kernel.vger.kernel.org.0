Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2813417023
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 06:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfEHEmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 00:42:06 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40224 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfEHEmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:42:06 -0400
Received: by mail-vs1-f68.google.com with SMTP id c24so4962389vsp.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 21:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLH+/uAC3vUrfOPxTEYrno+A0sUf0tEBN5RGNCkywlE=;
        b=bHdHAm1+CelPIzEDiciBV1JovJqMomr8rEGeKkRsjJmBBl+YaJDuqnA64n/UEQJ27y
         e5HyHtdd6RG2xiy/5+q3RRVK93nri8iCQNPdH/WqBXk6KrQk2VfpY8uXAtmChJX11ssc
         EgDUjLKx4PRFbBOiGGd8EsU5V56bBc+vANs4V3wMLZm6Ys10DKms8N7/4Ba3hxWILbkD
         ikaEpvTcRJcw4C/0m/i/lyfwc11qGoXXUTGqEkuuUAIoMh9MXUCEgJxm6KlrrIZQyZ/7
         FcSyueeJaH68nLZxyi2A7IwD9TK3jckpkhBguSFJJmMphf8oIpMlJGMOjkvHBGCGoyt/
         352w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLH+/uAC3vUrfOPxTEYrno+A0sUf0tEBN5RGNCkywlE=;
        b=MNBSXPpPi+2L2GQQoeTCI+Ei5a023ETU2oucpRfJUTT0f09znVZhHPm6/3DBguHjAm
         NDUDxrkSyIExbEpe8cgvYCYL7CcVG6ewGbwUu7bqkGJAz9DHHtkB/ExailPyrVwprph3
         DXzp6BFqtVr0TnYhg7VJEinygtmWKOB1A0CD8oY/MFBI0ZhEe4o46Lrlc4Fn+owkJb7g
         2kAtdVY997JS1x87ES6YYTpKqQDKgeLtRWJzrpY7fGQEfG8BKzddmEqe9++Vh59C6wVg
         WFzTpdKenffdJb1m7jA9LCC00WRcJqIIPRGI+YSpQDVXc0xiSFHv0loATrbIIsDTD7PA
         d1mA==
X-Gm-Message-State: APjAAAWpLunQb3mONW5uC+1zdIpMq+Q9+swIsxsKmLS6/GT7JfwzUFUj
        MLmQbKv294qHJlQ1J7e+WdI5WeBod2OoxhUwyyZ+Gg==
X-Google-Smtp-Source: APXvYqwfoRhHzPIyICbbAUAN4AgwVMMPziNZGoNKELTPvfctvJKaLAIj1Gjmz92THJDNw0ZtgSbKRFrqhQVYj54vsBE=
X-Received: by 2002:a67:d887:: with SMTP id f7mr9258563vsj.141.1557290525198;
 Tue, 07 May 2019 21:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190415155636.32748-1-sashal@kernel.org> <20190507174020.GH1747@sasha-vm>
In-Reply-To: <20190507174020.GH1747@sasha-vm>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 8 May 2019 10:11:54 +0530
Message-ID: <CAFA6WYPk5Bm11RfaC72g_C8rnMQEPyp-MhtopmDM3Of31v1Z_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ TEE ML

Hi Sasha,

Firstly apologies for my comments here as I recently joined
linux-integrity ML so I don't have other patches in my inbox. Also, it
would be nice if you could cc TEE ML in future patches, so that people
are aware of such interesting use-cases and may provide some feedback.

On Tue, 7 May 2019 at 23:10, Sasha Levin <sashal@kernel.org> wrote:
>
> On Mon, Apr 15, 2019 at 11:56:34AM -0400, Sasha Levin wrote:
> >From: "Sasha Levin (Microsoft)" <sashal@kernel.org>
> >
> >Changes since v2:
> >
> > - Drop the devicetree bindings patch (we don't add any new ones).
> > - More code cleanups based on Jason Gunthorpe's review.
> >
> >Sasha Levin (2):
> >  ftpm: firmware TPM running in TEE
> >  ftpm: add documentation for ftpm driver
>
> Ping? Does anyone have any objections to this?
>

From [PATCH v3 1/2] ftpm: firmware TPM running in TEE:

> +static const struct of_device_id of_ftpm_tee_ids[] = {
> + { .compatible = "microsoft,ftpm" },
> + { }
> +};
> +MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
> +
> +static struct platform_driver ftpm_tee_driver = {
> + .driver = {
> + .name = DRIVER_NAME,
> + .of_match_table = of_match_ptr(of_ftpm_tee_ids),
> + },
> + .probe = ftpm_tee_probe,
> + .remove = ftpm_tee_remove,
> +};
> +
> +module_platform_driver(ftpm_tee_driver);

Here this fTPM driver (seems to communicate with OP-TEE based TA)
should register on TEE bus [1] rather than platform bus as its actual
dependency is on TEE driver rather than using deferred probe to meet
its dependency. Have a look at OP-TEE based RNG driver here [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0fc1db9d105915021260eb241661b8e96f5c0f1a
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5fe8b1cc6a03c46b3061e808256d39dcebd0d0f0

-Sumit

> --
> Thanks,
> Sasha
