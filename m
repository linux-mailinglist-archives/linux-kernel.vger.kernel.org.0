Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8116B6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 01:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgBYA11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 19:27:27 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44694 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgBYA11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:27:27 -0500
Received: by mail-il1-f195.google.com with SMTP id s85so9305675ill.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 16:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SQsmpamnEC+1G39fOnv3AHWet4T1m/yewhekPzkg6oM=;
        b=BQCQ10WEVUabUm+celhXtz0JdV/fkLvArkq4WsPhiiiAA43MY858di0FZp521E3XTa
         5gqYAYDSdEkYN7SnEs4kyHgKuDAokjOrwg8sDzoyGx+kRiRQoeYPAVL27o3UY1SptQ6P
         pawfnNYmAT74vVjX3bw3QxdpPYAKa7PertS4SDxi5/4YRqLx4WUWY4Ylh1MJTe0qeGqM
         r7Zso+I/9Be7mulc84it+ioN3JpDc0n0Kd2afVxxvFbzx11l8++ZB3RGjGPJCEOH5hAH
         GLMKZmfBiPVmTF/1Gi+sS0w11tan1GNl6HxPE8SWZpwc/YwfxcOn9Pqvsn0bWAq+BB1q
         KTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SQsmpamnEC+1G39fOnv3AHWet4T1m/yewhekPzkg6oM=;
        b=jiu4XJqyxdOia2uQdn7IhHFjHlCeB0FxQu/gCBZg2vmiUemD+sqBsMKKcDltFCFqHs
         2qDGVt38TswMh+HHv0EeF02lis7c3Z3OIAnlSKUYFF4Q+iVgahexff1BR/zLLA2zBEYv
         v1cPkiITg8/BrAnVx0I9CwMBp8+1hd4ukbvonr2XT2ODZiO9FnWxdocyyHdzKCvJC8FU
         xtD8om8KaKbvKh59PE56rovGqgka243aQkKY7u6JCvOh8XDTG3yg5lOaez8jbj/jz9Gj
         tk2zrWwfesCEqG5vCYpYEV2p7LYeS/jLvmy+S7pOzDf/AJThXXVWyjebzO37OPLrqyyN
         RzdA==
X-Gm-Message-State: APjAAAWHwvbAoSG2aWd+3nnOU62TP2ugFq3em7mlnc29/kPV+VeeX6ld
        T4STkcUyd0DcGhqu/lL01umqtlgEYT82jDpg0qLTGDLJ
X-Google-Smtp-Source: APXvYqywoJznArA+B42fE3qotZLbAO/lZwwwFgSnCIFaKH0Kz32B3tEXhjaA2SpvadNI/Y+gQm5xbMlQ4ziEB+Eb1ho=
X-Received: by 2002:a92:db49:: with SMTP id w9mr59714964ilq.277.1582590446536;
 Mon, 24 Feb 2020 16:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20200224233146.23734-1-mpe@ellerman.id.au> <20200224233146.23734-3-mpe@ellerman.id.au>
In-Reply-To: <20200224233146.23734-3-mpe@ellerman.id.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 24 Feb 2020 16:27:15 -0800
Message-ID: <CAOesGMhHSYHvAXAH-kBxxGhd05Q0bbxDa9dyuw7oKTH96PTi0w@mail.gmail.com>
Subject: Re: [PATCH 3/8] powerpc: Remove PA SEMI MAINTAINERS entries
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 3:31 PM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
>
> The PA SEMI entries have been orphaned for 3 =C2=BD years, so fold them
> into the main POWERPC entry. The result of get_maintainer.pl is more
> or less unchanged.
>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
