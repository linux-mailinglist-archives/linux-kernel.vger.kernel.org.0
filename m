Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE30E15AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 11:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403828AbfJWJXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 05:23:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45910 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390380AbfJWJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:23:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id v8so14872824lfa.12;
        Wed, 23 Oct 2019 02:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xM47tMjvVTJk78I1R2uBA4cSFStES95D44l8FAkki5w=;
        b=eVYuBZtRRyK9nzSFkGqFmz1tzJ1KVjf/d4qiaqgFRaP71gUc7GxDVmb1gBs6F7fIId
         WyF79GWZNDM3vLBIwebxKVB1fBidi94E1RszNVPGAnti4PJnkXiN+R9yP7JGixNOugf5
         EnwQnhgzaXdc+rVKYJvDFbSbzweavunULECtYRI1XdZzRL/u/20OvfdrBZjaDeaOgIin
         b2QG4dQdUNKaAGEy5JRRzyXp74oJ5e8g73IgnWViTZ1jzeKJtdIvtpwGFd70eHMwclUz
         7LzBeooprsqdvskgXOIv9muVeAFBchZfmNdUNocFSQ3SQ91/4XUgPtBTy+cFDALTGutl
         5WwQ==
X-Gm-Message-State: APjAAAVuf52QFgefed+SKX+sYPpLWAt5epssbawST0Y4DtoPkl/3nb28
        jyucbDSN7AH6jXrFoGJaICM=
X-Google-Smtp-Source: APXvYqy/9o2C1CjcTLjn28ZhPCdYqzhGE6WGLj6PQlKcUwdjhezwvdvOSSj7cu+LwVQMiTzZNCVeQg==
X-Received: by 2002:ac2:44ba:: with SMTP id c26mr9442284lfm.20.1571822579520;
        Wed, 23 Oct 2019 02:22:59 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id v16sm5139294lfg.52.2019.10.23.02.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 02:22:58 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iNCrL-0006Xt-J7; Wed, 23 Oct 2019 11:23:15 +0200
Date:   Wed, 23 Oct 2019 11:23:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 1/7] USB: serial: f81232: Extract LSR handler
Message-ID: <20191023092315.GS24768@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-2-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923022449.10952-2-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24:43AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Extract LSR handler to function.

Try to always provide a motivation for your changes, don't just say what
you do (e.g. mention reusing this for the new device types if that's
what you plan on doing).

> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>

Johan
