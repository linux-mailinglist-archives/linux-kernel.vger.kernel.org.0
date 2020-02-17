Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C14A1610AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 12:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgBQLJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 06:09:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39105 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgBQLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:09:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so18001029wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 03:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T6lGwTZh7mHp1+xNe3270Amp1AhzDEDQq2tbWytRCkc=;
        b=xr0RKjXPVB+gRMbXfexYJNKjyWWOmWW1mV7pdgRe9rbLdRCTO7bxfxbB3RwTUZACDH
         LC23a15L1dYMi/FvFeXO4Ab3APGymTX7wpNiPQNR/rJ+XbS4NRNIrS5iGb+/s8dXyxq3
         nJIp/RZHptbqhL91IkiPR1Q8Lb7a2bL+wwDax9bViLe375QUVxC5xYMPzfrTvJSN/jPQ
         V7GuOtfoyH/3rOnTx3uaNg4o+38tLK0xtCHEJWzC876dHD54ONAsKoIxrbzjUxGwktK8
         qkmR2b2HB8vZD9IenM9u0qOu91wVN9zi7aZ6qd+uF4u94zyciEdlyPHUTgzzLYbjoVdo
         8BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6lGwTZh7mHp1+xNe3270Amp1AhzDEDQq2tbWytRCkc=;
        b=Sl7pStkRV+ngiRHDpNUUkKsP8RorH0fUwkXU3wYgm2Vyka2jzt9YQv1vNaUEqYccNe
         JScLcgpM3U1JJpxsi+zDe77iYC5BGfzq1Ef8SiURazMzieeUzs0QQ9L8VzlczgnX7jIT
         wYtA3IpojUP7WLtAyoHgLTl9oXSwUaimv0xCAZDVtJgDKIqT6MEMyu6a9Io/O5gAbdvN
         I2Uku4G8CU/4D/fIpGk1l99Tj5if6abLVgsiUijOsBZvMh976xmwjeFCeyrGL9Q/HJ6I
         1lDl4ZkN47c7rETOTkRITgXc829VMsBg5W5Bnh1WDy17lqAGzpUPV4OFPCO7ewZzR7XC
         K6tg==
X-Gm-Message-State: APjAAAUPN8sse+VKlgZWMCV+adSsTYXdgcDaKjV1+WwaMARJ5hvGAmEW
        f7C+CpC21BACMLJ56twhQo9/xw==
X-Google-Smtp-Source: APXvYqwxkBnN7m+XKv747Z5vrFKzOGd501tfmlf/OlM+5CYpkdwBSTAEIw/f9X5gGNN2xTTgzKUdrA==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr22120513wml.110.1581937749544;
        Mon, 17 Feb 2020 03:09:09 -0800 (PST)
Received: from apalos.home (ppp-2-87-54-32.home.otenet.gr. [2.87.54.32])
        by smtp.gmail.com with ESMTPSA id u8sm178649wmm.15.2020.02.17.03.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 03:09:09 -0800 (PST)
Date:   Mon, 17 Feb 2020 13:09:06 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 2/3] efi/libstub: Add support for loading the initrd
 from a device path
Message-ID: <20200217110906.GA147685@apalos.home>
References: <20200216141104.21477-1-ardb@kernel.org>
 <20200216141104.21477-3-ardb@kernel.org>
 <4e427366-4141-e360-b1da-c5cb37f8092b@redhat.com>
 <CAKv+Gu8h17EdfEW_DDE9S_drLTJ3e3pVzJG29uij5DoGGMXpxA@mail.gmail.com>
 <CAKv+Gu8LEBFiXOXWv6nbKFpKvT8whaLr3-DkcHSNzW3BRTi8iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8LEBFiXOXWv6nbKFpKvT8whaLr3-DkcHSNzW3BRTi8iQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

[...]
> > > > +             return EFI_INVALID_PARAMETER;
> > >
> > > Doesn't return EFI_LOAD_ERROR.
> > >
> > > > +
> > > > +     dp = (efi_device_path_protocol_t *)&initrd_dev_path;
> > > > +     status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
> > > > +     if (status != EFI_SUCCESS)
> > > > +             return status;
> > >
> > > Seems safe (the only plausible error could be EFI_NOT_FOUND).
> > >
> > > > +
> > > > +     status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
> > > > +                          (void **)&lf2);
> > > > +     if (status != EFI_SUCCESS)
> > > > +             return status;
> > >
> > > Interesting case; this should never fail... but note, if it does, it
> > > returns EFI_UNSUPPORTED, not EFI_NOT_FOUND (if the protocol is missing
> > > from the handle).
> > >
> > > > +
> > > > +     status = efi_call_proto(lf2, load_file, dp, false, &initrd_size, NULL);
> > > > +     if (status != EFI_BUFFER_TOO_SMALL)
> > > > +             return EFI_LOAD_ERROR;
> > > > +
> > > > +     status = efi_allocate_pages(initrd_size, &initrd_addr, max);
> > > > +     if (status != EFI_SUCCESS)
> > > > +             return status;
> > >
> > > Not sure about the efi_allocate_pages() wrapper (?); the UEFI service
> > > could return EFI_OUT_OF_RESOURCES.
> > >
> >
> > Hmm, guess I was a bit sloppy with the return codes. The important
> > thing is that EFI_NOT_FOUND is only returned in the one specifically
> > defined case.
> >
> 
> For the record [in case no respin+resend is needed for other reasons],
> I intend to update the comment block as below, and keep the code as
> is:
> 

Yes i think this makes more sense the return codes are already correct and the
fallback is properly triggered.

For what it's worth 

Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> 
>   * @load_addr: pointer to store the address where the initrd was loaded
>   * @load_size: pointer to store the size of the loaded initrd
>   * @max:       upper limit for the initrd memory allocation
> - * @return:    %EFI_SUCCESS if the initrd was loaded successfully, in
> which case
> - *             @load_addr and @load_size are assigned accordingly
> - *             %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
> - *             device path
> + * @return:    %EFI_SUCCESS if the initrd was loaded successfully, in which
> + *             case @load_addr and @load_size are assigned accordingly
> + *             %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
> + *             device path
> + *             %EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
> + *             %EFI_OUT_OF_RESOURCES if memory allocation failed
>   *             %EFI_LOAD_ERROR in all other cases

Regards
/Ilias
