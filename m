Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF366605
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 07:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfGLFNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 01:13:51 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:39610 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfGLFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 01:13:51 -0400
Received: by mail-lf1-f46.google.com with SMTP id v85so5576817lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 22:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1l+yKMs5eoMYO2qnNQH2xVuYFvFDBbrlUII08j6+mA=;
        b=nYyYj4Td71VI953FAnyXurziweSCfNklLpK/20JzdgHfGVOtnzeWSnTD3QpkBj1m1j
         0+XmP7aKHmB2tFrjhco2B+BLfXxMvapsbXEtTS75L9D50cT/Q2k5mi6/ZGUMADNYJ6M9
         /wuGf83vcQk9fw1Hq2K8CgfhpnTk+MjsURGJYWwESfgUrX+cFxD0RX8+iLv9l+U1x+Ru
         +2L7b1HpO0WufLCNfWtO6u0yVL2VhFfuXVTpsxpQBt1N2FTYYnoKgiYAm9CTf7lQSH+D
         7//dX24mOdjvvoS0Rie7FLIkW9l4pAywDy0IClhfcvZNIxXxJhwrw4/kcgHqvDlhqhCu
         WXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1l+yKMs5eoMYO2qnNQH2xVuYFvFDBbrlUII08j6+mA=;
        b=jHEF3gap+GrA4YG3HTIVSudRZ+ekifNwj4t+N66gzexF2QuN4bk9qGy1kZlDdZ5A6i
         kLV8c0NgnvaKVkOl4aDi6iz1cRd9j8jDLQaUi8iDLiDWRbYiaVEV8Wn5bJBsYDuC9uDi
         6WVDpH6KQ1qmy/csbh2AcPL4LcZRXL/7A0jWiKjEG0exi/MLRG065287SvD+/hcEhlFt
         gvc/xNUPCeGNHSCPrywpCYZSIH/4/gvzoAheUVpBDMEN2Z0SoccmdtUJGL4mGuDlIUfE
         e6wInseN32Y9IF+gv2lkzKFniIDg13SDwtQ4fi3/69Ud58sCnhvvZmvT+Bmag+2yLN39
         qfFA==
X-Gm-Message-State: APjAAAXf+QrJS3QlE7fjli9uNqLqHS2v4SaBvWWcvhoofHag/rnvNGvE
        r2FLqs897BIbq0IsF0DMm7XPW5QFyeqOB5pWEXCccA==
X-Google-Smtp-Source: APXvYqyfBXA9XmXbGZHqcWD0t0USlZpN+WDbCnrmpXLdBk+4LqbchAml/Mo4CSWEgwoiXHjQ8mHI9xNYcHbD44LAJNo=
X-Received: by 2002:a19:c7ca:: with SMTP id x193mr3592234lff.151.1562908429171;
 Thu, 11 Jul 2019 22:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <1562337154-26376-1-git-send-email-sumit.garg@linaro.org> <20190711192215.5w3fzdjwsebgoesh@linux.intel.com>
In-Reply-To: <20190711192215.5w3fzdjwsebgoesh@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 12 Jul 2019 10:43:38 +0530
Message-ID: <CAFA6WYMOyKo2vXY8bO448ikmdGioK3s5JMZLz6c2y8ObPm4zHw@mail.gmail.com>
Subject: Re: [RFC/RFT] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
        jmorris@namei.org, serge@hallyn.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019 at 00:52, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Jul 05, 2019 at 08:02:34PM +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device as
> > an underlying implementation which makes it difficult for implementations
> > like Trusted Execution Environment (TEE) etc. to provide trusked keys
> > support in case platform doesn't posses a TPM device.
> >
> > So this patch tries to add generic trusted keys framework where underlying
> > implemtations like TPM, TEE etc. could be easily plugged-in.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> 1. Needs to be somehow dissected into digestable/reviewable pieces.

Sure, will try to split this patch in next version.

> 2. As a precursory step probably would make sense to move all
>    existing trusted keys code into one subsystem first.

Okay.

-Sumit

>
> /Jarkko
