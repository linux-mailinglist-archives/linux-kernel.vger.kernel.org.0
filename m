Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13ED1156732
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 19:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgBHSpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 13:45:52 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:41760 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBHSpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:45:52 -0500
Received: by mail-lj1-f176.google.com with SMTP id h23so2709285ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xZ3lclt+3lDvIMTFBN4tJCQsj+k/glReI9PLAIiRfw=;
        b=LGwEuLRkO2QeXVeXm06hRMVAtWWxexaZU8h62nJ3WCR/jl9Sy7Z2Oq8lW0E2V3UHeq
         uyHVJ1oCcMeyRTmbgoOUT5kqW1YEY2xts2j/R1LJlR2tjk++qqAtJmMkqTyqBTVse3yz
         dzlaGNS8x+ZHONR9H4tP36Xu1LUNJPyyf2acw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xZ3lclt+3lDvIMTFBN4tJCQsj+k/glReI9PLAIiRfw=;
        b=Y/n7GGeSd4GK0Sxf7/auJUreN5gDDsg1/VldDGuhfOFVbX5XHllHQ2xBGRmND50kF1
         zXJ5HnAdlXxWbudtn7apHSDzaea/CGIeP3oS2wTO2i22aMIgE80rJMTYQmPVaiGaZkL4
         M4mH1n5L+TFQMZWRKS0QwT8bVboyG4gNaPEXhvAx9HckhkGxr6QxNb2ozXzwf6O3EZ7O
         ZvfKwJh0IxmDHCjiOpARrq+GJrDYDb6F8bnwSsSfFPuUsixEYDbvf9h7qTz/HUgErr7K
         uKguLxxCSGLJB00ChQ4AfvcozaRhuDiNHDagCQ1wRHo4Ka15KRO6tjsyzxDePlRgfoKz
         DTmg==
X-Gm-Message-State: APjAAAW7NtAM5GoBSwjIHpBgUc7G/CWvI2sHtTNEnEVoXYplWuxVRT6o
        b0wwme0J1+42E3XM/cRLs28Zwb2S6hw=
X-Google-Smtp-Source: APXvYqzGllCOo5C+bNkgbnItPSjO4s+zw5HLVWOSfm0GLDLNxoN6eO3aJTIX7kw7qSUNtaQoLglu1w==
X-Received: by 2002:a2e:22c5:: with SMTP id i188mr3324162lji.34.1581187548283;
        Sat, 08 Feb 2020 10:45:48 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b64sm2935847lfg.7.2020.02.08.10.45.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 10:45:47 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id x14so2680170ljd.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 10:45:46 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr3333019ljk.201.1581187546589;
 Sat, 08 Feb 2020 10:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20200208083604.GA86051@localhost>
In-Reply-To: <20200208083604.GA86051@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Feb 2020 10:45:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWe0tY3aDraTk_Wesj8PMH+=U=W3VTE2aJCHNE+u+WTw@mail.gmail.com>
Message-ID: <CAHk-=whWe0tY3aDraTk_Wesj8PMH+=U=W3VTE2aJCHNE+u+WTw@mail.gmail.com>
Subject: Re: Applying pipe fix this merge window?
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 12:36 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> Based on that, would you consider merging the pipe fix patch in the
> current merge window, giving people plenty of time to hammer on it
> further?

Sure, I'll apply it and see if anybody hollers.

Worst case, we'll revert if there are too many people who have the
buggy version of make and can't easily upgrade. But even then it might
not be that noticeable, since the make jobserver problem ends up
benign fairly timing-specific too. I may have just been very unlucky
in hitting it back when..

            Linus
