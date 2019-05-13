Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D001BF73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 00:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfEMW1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 18:27:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34898 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEMW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:27:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id m20so724167lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIXHe4yUSfdrp9HQnXwzm5xnUgCGBYJjN/aTrGgciFg=;
        b=UbvM3qdM2IYMhQLjreSGZnt/x+FCbuEvoJPPE25HbqSn+U7x5UFQUy77cpB6DQr1Uz
         DKpef6Cem2myIj++n9/vukZC+pEm3yvoHUBUDt+bvFkYQvT7uXA8o84+cij03Ii6Et3s
         w623zZmRc2qgAVQoOk3TkOel9hMgwXg0t/S+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIXHe4yUSfdrp9HQnXwzm5xnUgCGBYJjN/aTrGgciFg=;
        b=g793HqQ1KI3BX5rWB0em1hfXH2FhtEWDxUxI+W+fyHrJuSPx75oFVgvKpBPWc5M0gP
         lJMpbQV3pPutRSy9A3i4HNQsPCg5LhtYabxYVyqUEO1FUDAkUEayn43jBcNQrAMaRJZM
         7bvcMGKhj7xoKDGcL281Y3nPIQJnOyQx8ej9F2aXO4f/hZfChrzmcjBgaCqSukLu0khd
         7CM4J4bo1eyZbehUNm2veaH+2hVJHSozgbE8+noa0rgCC9G8K+F9tIP124Y7n3j3ZMq4
         Z2sS7zbEXwnZwlM9njCAOCBG2fqFEDD9NbpeTmBmOrDKssvfd7gDU7+i0A/1SvpG8cD6
         JmSg==
X-Gm-Message-State: APjAAAVdrsuR5fbqmNeI0m/PjEmGpOzqI/69wJ2drknYOHBtm8YMr3zh
        txgmEt/WA5YFZVTV1Gf2eMhAq77bPhE=
X-Google-Smtp-Source: APXvYqxryAosqB6NGuCOeUvXp/goLjeIQkk6yxOrqUuBLM3FtgYzBsQ7wVX1fVYeebe0qcJ/HkIaOA==
X-Received: by 2002:a2e:9716:: with SMTP id r22mr2930060lji.175.1557786460805;
        Mon, 13 May 2019 15:27:40 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id j6sm3737848ljc.0.2019.05.13.15.27.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 15:27:38 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id d15so12473307ljc.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:27:38 -0700 (PDT)
X-Received: by 2002:a2e:1312:: with SMTP id 18mr4551964ljt.79.1557786458363;
 Mon, 13 May 2019 15:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190513195904.15726-1-agruenba@redhat.com>
In-Reply-To: <20190513195904.15726-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 May 2019 15:27:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=yz_=6oM1r5C4pWJPac8cD1kHiki73wDciuLLoRNY=w@mail.gmail.com>
Message-ID: <CAHk-=wg=yz_=6oM1r5C4pWJPac8cD1kHiki73wDciuLLoRNY=w@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix error path kobject memory leak
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas,
 did you intend for me to take this as a patch from the email, or will
I get a pull request with this later?

             Linus
