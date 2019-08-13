Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD68B1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfHMH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 03:59:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42670 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfHMH7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:59:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id 15so8919892ljr.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppVR4stowlIJ6/4pZZBiqz7XFOa7GBtQMtynjohKpDM=;
        b=gMNzHJkjPlTKg8J3P1ItvpHxlkyUzWeShHE+QJSJ32VauPTGnzGKsD+QuZrHHI76pj
         RQaLjgiFHttMYl1YL5egx0p1M2IIOgyXxDeB1ftBhbKgE91RpNxJqdP+/QCc15BfoOhL
         Z1+PP778xl2OwXclKn24vrxEMqdB2zsz1S9Mo+1+LLBC3XvBF1qfh81VIeKQdgw15Wfs
         3UPAiB+GQfna3uzgBhqY2DIQZ1U1Dd6wdEjtIkq7MQrftD+JJ76fJF/zUJB30qtgXZ8g
         gkbmkqgpWNNJ+9OWrPYhYkczySrcOktUtmOi5kVY6tzWBM01UKaeDCvccNuWK35inzMd
         u0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppVR4stowlIJ6/4pZZBiqz7XFOa7GBtQMtynjohKpDM=;
        b=nAZIlAx64zFvDwscgwSZdBRP7LIBA8NjXA2t/yRcFag3lE+AQeSdHsNY8b551lp7F+
         0PT4EjFmmjTqhhG7wz7XG81gxihGLmonoexQhpz7AV74lSdQO+OdvlAPnajhpwuWAkTd
         BcAsA7sWGG2cc1+2HFpB9PP1zq/DrBG40wggmXEpa3TJEnJG7CqIpWDHYpJhV4KUX4C0
         MwG00Krp9QqeIh7Ub//13Jwlv9F7ccwTV3KSSQo8kBGUvp/NnmTDlQJY0jhUJbZns201
         HVB+j3tt8bCV0TDsrw14QbsRqYz1/BFjmb7xJjJQbOBa4FDHxHPRx1v2O93PYBGZnq8k
         bG2Q==
X-Gm-Message-State: APjAAAVya/SgdTXIwtfAAvhx9wbBj2F/Fk6qg9Z2ckctj14UAWsbXAap
        t12vHecHrse9qyTACQHHVJPlRP+6TbTTInD80PeAnA==
X-Google-Smtp-Source: APXvYqy9Xa1Q8vdR2OCkDVG7ShxG5L9IQXmi6qKK2LlN8HtiapeB1JlrnTXdtXIphrZmMJ+SZciCiafKR0IU/QMDd44=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr19876829lji.115.1565683170315;
 Tue, 13 Aug 2019 00:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org> <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
 <CAFA6WYN-6MpP2TZQEz49BmjSQiMSqghVFWRZCCY0o1UVad1AFw@mail.gmail.com> <20190808151500.ypfcqowklalu76uq@linux.intel.com>
In-Reply-To: <20190808151500.ypfcqowklalu76uq@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Aug 2019 13:29:19 +0530
Message-ID: <CAFA6WYNqBH9aAM-uke6jFTCeLB2GG7UYyrYEPHgyVy8p_q+Pww@mail.gmail.com>
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 at 20:46, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Aug 08, 2019 at 06:51:38PM +0530, Sumit Garg wrote:
> > It seems to be a functional change which I think requires proper unit
> > testing. I am afraid that I don't posses a TPM device to test this and
> > also very less conversant with tpm_buf code.
> >
> > So what I have done here is to rename existing TPM 1.x trusted keys
> > code to use tpm1_buf.
> >
> > And I would be happy to integrate a tested patch if anyone familiar
> > could work on this.
>
> I can test it on TPM 1.2.
>

I have posted v4 with changes as you requested. I hope they work well
with a real TPM 1.x or TPM 2.0 device.

-Sumit

> /Jarkko
