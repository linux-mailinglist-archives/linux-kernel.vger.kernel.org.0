Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0BF1222
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 10:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfKFJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 04:28:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37445 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKFJ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:28:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id q130so2470419wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 01:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3+KCnUf8WOvQBwGU9Oud+rYOXUiIWLNUwyrFKvDsLg=;
        b=GC/Fta3pGv/yKyS5B8S/PBBqYglHDJviZKlyL2km88JUccjtMEO4PZEp1/8c1Zyni9
         P8pmEQ47HJQ24DGehwQjXYqGoJgYy8oMy3al7G8iza8LXMRNjA7PAsrBaOuyrc9YDM3+
         FAV7s/yn42R0lmcMu+cbReaXX1w3zYx7P/YfFmDB8T/KJwsH9uhyeNZWrS2Ij6NACZUE
         XcQUJdl7vAOhmFfbDwWwXgYfhXDmzQwF7YRHkQYSZ3gY5mDN9b/HzXCpxf288PEzDpzo
         MLz1XT7IU9hcvfqPtUzArYHBDGTvz+wvbMZvTZAAwLVfUXHaIV5NK+wsVHZkOcFvPftU
         31Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3+KCnUf8WOvQBwGU9Oud+rYOXUiIWLNUwyrFKvDsLg=;
        b=Jr+FK8A57O7yTCCEy0ZWbKkBpkpURqnt/vSeDSsiywLPzvdLtJ0rzgauzZvrTqVZ7Z
         CRpaSCocLK53QJqfrHgzvTAutWVY2wRw59Gyc7MYfZzxjz8VWELLul8NWsQkZEtBLJss
         1bsexFwQAMMEZskCqMLizO9BHdhzl0MtePbqkf3yecB7mvtoUdKwCiMd5e4r0v3sHGDY
         sgzOdvEJbgEMvufpjacpfNTI7mXYSjHpAOm7EEJXlHKVzFnV/+D/MX65I2/KEc2uTsHV
         9Mzt07aMZrFx2LQsptUO4g5gY7TwWGweX2HfdVNkbKo4GnGlTpyMhzK9LlJWNfYLLYzD
         8sVw==
X-Gm-Message-State: APjAAAVFVYHiPJAFQkWMqzrns9rotvhc38l1l+NK/kYu54aO+J6hRaFt
        vvbGfOk8kStAxeUboQEdpRADp7hcUKJi2bQeyMxBS8Js
X-Google-Smtp-Source: APXvYqyLFvWViVYcIi1lMoqGfXU0QyE+21FZQgdiA1NRAvliwtXWDuBVt1fo8vNx4HmcjSKnFINX6/cxjjh/hgDjwz0=
X-Received: by 2002:a1c:9d13:: with SMTP id g19mr1468233wme.159.1573032499669;
 Wed, 06 Nov 2019 01:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20191106074238.186023-1-pliard@google.com> <20191106083423.GA10679@lst.de>
 <20191106083711.GB10679@lst.de>
In-Reply-To: <20191106083711.GB10679@lst.de>
From:   Philippe Liard <pliard@google.com>
Date:   Wed, 6 Nov 2019 18:28:08 +0900
Message-ID: <CAEThQxe2sNuCHoQfa30FVmtYkQ_zJsecdW2wmVmwafvne1RXSg@mail.gmail.com>
Subject: Re: [PATCH v3] squashfs: Migrate from ll_rw_block usage to BIO
To:     Christoph Hellwig <hch@lst.de>
Cc:     phillip@squashfs.org.uk, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 5:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Sorry for the empty reply.
>
> This was meant to say that the patch looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!
