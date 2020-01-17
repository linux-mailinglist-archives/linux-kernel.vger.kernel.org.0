Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03FD61413B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgAQVwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 16:52:22 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42002 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:52:22 -0500
Received: by mail-io1-f67.google.com with SMTP id n11so27597913iom.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zjQSft/7NYSlsFJpIJXa+QqqnK9LdZDneos7vXG6e8U=;
        b=DyEq/hO8s4RZ+2iZ2TdF0sCag4usxI3IV+LW66SjqfJX3rwnC1ZGJHJSZhOGhZmvAK
         kQwTRgq6NW+MozpJR4MRfVmSO/wMDbZry0xANexqWvW8vJeElOXYWTnu/3CKw9eb6+RE
         aCO9SoMkbQCVq4bE/Kch+kDMFy54kHoSbNAkR4u9NrxejyV9dVVKI0Rx4DLt+awesfih
         RrVEu/bcSG2pJjyx0uCjii6LOF5hAIINaP82K+kDr3NTSycSJZ2U/iZP9CVchB0dgCf8
         HleBXwjXI32smI1oNmSWJxbIsEB9rwNVFjKn2ExvJibhuZLFTKFfIqNLg6e63yxxfTvH
         sLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zjQSft/7NYSlsFJpIJXa+QqqnK9LdZDneos7vXG6e8U=;
        b=b6FtaJjo+8gkLShup6OQkztKa2wVm29Nz9nVYrBztzk8NvM3vHCekQieVfrBZdrDdV
         b5xpiYxdJDeKHCW9i8A0bpiH9VcuR0CDpmIMDnh1NOWE6g056p4AEVFuXZxULPbaNEav
         lMkriOTKfoyIlGMTwWakg/XYqr9vuRXMboY1sDRussR6F4eIbmXIi+RiKQ3Nhbpl4xl/
         T/kT8cNLx5WqihO4ktKnrTaMmB0sSjhfrAeYOmaAlH0xdPNsn54ZfSnd5b8YqlQKofIP
         n3Q3dJjwEI5x6Izk24aOoMbZAJ056wYZQlAsUDEP4DmzbTDAEicVE8FoGQuJTG1nKqdk
         W8Vg==
X-Gm-Message-State: APjAAAWxi8foQvdMQ++EbLzQCyzFRTaXoh3IGqCO1QL7gnbUdwZ6HR6v
        k01cGnwLFwuO+upLYLaEhBIEhQ==
X-Google-Smtp-Source: APXvYqyOI2ac0khuK6ygC3i3ZJ0K7jAaLTP91Od5vfsxqrMwyAW8rIVzKYRGxYrOiKkArJC9tu10wA==
X-Received: by 2002:a05:6638:102:: with SMTP id x2mr34374608jao.71.1579297941757;
        Fri, 17 Jan 2020 13:52:21 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id y62sm8243344ilk.32.2020.01.17.13.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:52:21 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:52:19 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Ilie Halip <ilie.halip@gmail.com>
cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Mao Han <han_mao@c-sky.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: delete temporary files
In-Reply-To: <20200115113243.23096-1-ilie.halip@gmail.com>
Message-ID: <alpine.DEB.2.21.9999.2001171352080.98477@viisi.sifive.com>
References: <20200115113243.23096-1-ilie.halip@gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020, Ilie Halip wrote:

> Temporary files used in the VDSO build process linger on even after make
> mrproper: vdso-dummy.o.tmp, vdso.so.dbg.tmp.
> 
> Delete them once they're no longer needed.
> 
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

Thanks, queued for v5.5-rc.


- Paul
