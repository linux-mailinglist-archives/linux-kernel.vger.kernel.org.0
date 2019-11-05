Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B15EFBF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 12:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbfKELBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 06:01:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36600 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfKELBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:01:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id w18so20826906wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=EZghrgWEU7PinMbxhgFFAGKP8eV2Li80iVqhELRRUNk=;
        b=R14zOSWyNvnQV94JDavTe85Z2Fw5Vh6JQY1YZyMFH78lqlQ4CFLQK7+AK3SIm8RV1W
         TgFgLPQuZkG/NAFioFBsPbrIfyUKjtJxvQGvRbCzrgILMad9ix/4OabzQJyDcYwgWRLI
         szNcSya8o5WB6aGzYVgRCywhGgV0/aEH4h1ScNVje3D1nu1yvysHJA9ZNaM8sSVITay1
         +MwePjVMuQn2DVL50ykuPTlNJfGnmQJNIaNnoHatgEfhhO4pa6iLY5NQbjSeKWLIa2VJ
         bbxCkFYcBGUU9W+kGodO7729kMfdevtedaVuGwIGuQGf0SivS06ZRc8+X47mjlTl2m+I
         j1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=EZghrgWEU7PinMbxhgFFAGKP8eV2Li80iVqhELRRUNk=;
        b=EJ9vxhMFP/VCe+og+Ml68vq6D+qLZLKs3dXXlo1UpNpQdOrYPxRbz98iOc8AZTaFr6
         HAJzU2jpk+srwQnMZAOCFaL6/scK0NORU6eumwr/6fKKTrT6ppCaGAOwFV5X3fsmeciL
         V73TNtKFzWj5CsyaOeEeoWCXoreYg0bzn7QSojEFkZzLkHb2DECCxog7Dhw/acEa+P+Y
         5BJMvC2De5/LqziQIOe8bPqDm1/Nw3Eiu5kuhrMmw+9J3TZkNt56My+bw1Ug+0wfNveS
         T/wQSCKSzPZxnpWmMMTtKhMa1d653H8fQzJBB8UGKO5ltf+J+j16BRu7bJ4BScMfF4Rb
         Ng3w==
X-Gm-Message-State: APjAAAW6FB27rBgXFJIHgAjYiMi49Krdj0bL6IxwnKCu29CZrxs6+sEJ
        4zAGXG0qi0gLc1N2YBfDzw==
X-Google-Smtp-Source: APXvYqyKQZkCpxcqCNeDNXiv68+h/wuBt2avz/C60IDr9TDpC+zLAg6nxXBiuknuLSIG2h47a7oeLQ==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr10457814wrq.40.1572951662765;
        Tue, 05 Nov 2019 03:01:02 -0800 (PST)
Received: from ninjahub.lan (79-73-36-243.dynamic.dsl.as9105.com. [79.73.36.243])
        by smtp.gmail.com with ESMTPSA id j22sm28263721wrd.41.2019.11.05.03.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 03:01:02 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Tue, 5 Nov 2019 11:00:44 +0000 (GMT)
To:     Ian Abbott <abbotti@mev.co.uk>
cc:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hsweeten@visionengravers.com
Subject: Re: [PATCH v2] staging: comedi: rewrite macro function with GNU
 extension typeof
In-Reply-To: <84a2d50f-a1ac-bdc5-989c-b0294e9dea22@mev.co.uk>
Message-ID: <alpine.LFD.2.21.1911051053560.11074@ninjahub.org>
References: <20191104163331.68173-1-jbi.octave@gmail.com> <84a2d50f-a1ac-bdc5-989c-b0294e9dea22@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Nov 2019, Ian Abbott wrote:

> On 04/11/2019 16:33, Jules Irenge wrote:
> > Rewrite macro function with the GNU extension typeof
> > to remove a possible side-effects of MACRO argument reuse "x".
> >   - Problem could rise if arguments have different types
> > and different use though.
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> > v1 - had no full commit log message, with changes not intended to be in the
> > patch
> > v2 - remove some changes not intended to be in this driver
> >       include note of a potential problem
> >   drivers/staging/comedi/comedi.h | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/comedi/comedi.h
> > b/drivers/staging/comedi/comedi.h
> > index 09a940066c0e..a57691a2e8d8 100644
> > --- a/drivers/staging/comedi/comedi.h
> > +++ b/drivers/staging/comedi/comedi.h
> > @@ -1103,8 +1103,10 @@ enum ni_common_signal_names {
> >   
> >   /* *** END GLOBALLY-NAMED NI TERMINALS/SIGNALS *** */
> >   
> > -#define NI_USUAL_PFI_SELECT(x)	(((x) < 10) ? (0x1 + (x)) : (0xb +
> > (x)))
> > -#define NI_USUAL_RTSI_SELECT(x)	(((x) < 7) ? (0xb + (x)) : 0x1b)
> > +#define NI_USUAL_PFI_SELECT(x)\
> > +	({typeof(x) x_ = (x); (x_ < 10) ? (0x1 + x_) : (0xb + x_); })
> > +#define NI_USUAL_RTSI_SELECT(x)\
> > +	({typeof(x) x_ = (x); (x_ < 7) ? (0xb + x_) : 0x1b; })
> >   
> >   /*
> >    * mode bits for NI general-purpose counters, set with
> > 
> 
> I wasn't sure about this the first time around due to the use of GNU
> extensions in uapi header files, but I see there are a few, rare instances of
> this GNU extension elsewhere in other uapi headers (mainly in netfilter
> stuff), so I guess it's OK.  However, it  does mean that user code that uses
> these macros will no longer compile unless GNU extensions are enabled.
> 
> Does anyone know any "best practices" regarding use of GNU extensions in user
> header files under Linux?
> 
> -- 
> -=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
> -=( MEV Ltd. is a company registered in England & Wales. )=-
> -=( Registered number: 02862268.  Registered address:    )=-
> -=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
> 
> 
Apology, I misinterpreted the comments and send a second 
version without thinking much.
Please discard it unless you wish to try out.
Any way thanks for the feedback, I really appreciate I find it educative.
Kind regards,
Jules
