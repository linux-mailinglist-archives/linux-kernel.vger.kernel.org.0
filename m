Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824F47EC4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 07:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfHBFuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 01:50:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40166 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388175AbfHBFuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:50:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id m8so38062291lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vwz8Yfm4Cow2GeEvNxlf9aEZE7OVt1rKT7raAjp8VpA=;
        b=X3oq7lAkHf3gv2MqFLGGzBIFgglHgG5rRPhA3IA/fycv6qEgWi/E/L84U6E0mZJF5k
         HaeRuMoGJlD1AnH/ujS8Un7jZdQyUMaemOE5kq531tVfuOAnjD/LU5AJx52J+CGFad+M
         jFedj9VOB/NnqbRUoJFCIu0uLsAjmh4zr0n2QpQes0qqSw36DYgPoBTlCdlefz4yPDzf
         ZDHoh285WC5GUXxkKWfRJJJ/jy4JL86Kqy8qWDtY1HoxHInqDQbFsced+bOAVZGpUwdZ
         Gcz9jma3dRlxxMCgIJpxiWALuPHaN0nxFpjSnOh3TSquP4VcgUfapw+xPsm/8Iv003js
         NRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vwz8Yfm4Cow2GeEvNxlf9aEZE7OVt1rKT7raAjp8VpA=;
        b=iC8Ra8zWK8LNPs9r1RKRaLCpVoEFJNiilspyHnb0DCe+kgWBaUNo/QRAebwuzwZuQM
         pWHzTCfOgYcFJkrHMdjh7JKvbN8onqFBsc5rB3LyX1EfGs1nwpbYE6uUSlxdE5v0hrRe
         X3XtEBDHObbiRD3UuzjCzX5NB3AhDi+up3S0e+gwWoSLa46dVnvyMPdK1+M7IhB8MgD1
         QQ45ir/1TbxXJXohL74sKlcWP/1Iuh6JU/MxlbyKERDC4BNv8iA7L/LsTQHjjnrlKodY
         WPb22f6T72OPstyCzLCVUcaiVFhFoknByJ68KMufdPGIfanjYcAv0Hl9F+EoNQeGeFG7
         sQtA==
X-Gm-Message-State: APjAAAVsjSm1aLG6ziBNshQQ6UXCguaJFIKMqrmDKA9hJNWLDrCQ6bAM
        CnYpXEKZFE1X8PVOu/3prIYDGGokN3clLf7v97W3RQ==
X-Google-Smtp-Source: APXvYqxa1pCtNqv5a9orx+jqYo5gAuz4nI99d0UZk2C8opZTrYtKmFiLmrw+zaVFcZxMgM+dWW013yJe1zTceqVxnvo=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr68823438ljw.76.1564725020734;
 Thu, 01 Aug 2019 22:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
 <1563449086-13183-2-git-send-email-sumit.garg@linaro.org> <20190801172310.cldcftfdoh5vyfjg@linux.intel.com>
In-Reply-To: <20190801172310.cldcftfdoh5vyfjg@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 2 Aug 2019 11:20:09 +0530
Message-ID: <CAFA6WYM+FQuXA9Saj5+ffOGsc-shhiF5Uos4g14Qndvu6w97Sg@mail.gmail.com>
Subject: Re: [RFC/RFT v2 1/2] KEYS: trusted: create trusted keys subsystem
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
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

On Thu, 1 Aug 2019 at 22:54, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jul 18, 2019 at 04:54:45PM +0530, Sumit Garg wrote:
> > Move existing code to trusted keys subsystem. Also, rename files with
> > "tpm" as suffix which provides the underlying implementation.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> What about TPM2 trusted keys code?

Isn't TPM2 code located here: "drivers/char/tpm/"? Would you like to
move that code under trusted keys subsystem only?

-Sumit

>
> /Jarkko
