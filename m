Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D85118C41
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 16:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLJPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 10:14:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35961 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:14:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so16291654edp.3;
        Tue, 10 Dec 2019 07:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rX25mRS0R7g3H36vg6LDxr3jtSDYFtlmlEW5V9/gpU8=;
        b=ZoJ+4DEAXEcKVSza2UlmyrsgMR//dPplOqwwZaqYF4VRwGqLfSQXQ8LjP4D6wiT4jp
         DTygpUQpD5TF95vJlc+3tIc/yYt13WyRIKEZGvpwaw5YB00OQc23oivm+gv61sHafJy6
         VH6Lt6OHz64oUhUknkufwSdNLL05gKtWh8irPlHe0DPf5Yo6OclUSnsqABK9o2nHzt4S
         DJyEnvHSGnhpnLLwsUBnHA4bI5Tv83/6iZiGkCXODCo7SbFZi+pD3Yrn6nZt+dIGV6mR
         sllkW2KYFbJ9nUg+Nw7MmmW+55NsJ3hf07tWG4nzhljuDyByuwacWT+T7aZdDmM5hzBs
         iCAw==
X-Gm-Message-State: APjAAAVMMSR8XFO3ngaL5XNJZ5qGtC1aJ26Pd/5HVMu2sRs9Ui4ams8K
        LGJVQf4wmmv6GISQvChKdSQ=
X-Google-Smtp-Source: APXvYqxNSi19yPBjqzrP1CJjzpcPh+Cif4qA9wuPjYukX6ukeWARbEqHYn1ret7hPkYE00vjlNw0tg==
X-Received: by 2002:a17:906:ff01:: with SMTP id zn1mr4176403ejb.323.1575990861966;
        Tue, 10 Dec 2019 07:14:21 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id r4sm73616edb.82.2019.12.10.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:14:21 -0800 (PST)
Date:   Tue, 10 Dec 2019 16:14:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] tty: serial: samsung_tty: fix up minor comment
 formatting
Message-ID: <20191210151419.GJ11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-9-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-9-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 03:37:05PM +0100, Greg Kroah-Hartman wrote:
> Fix up some minor formatting of comment blocks to make checkpatch
> happier and to make things look more uniform.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Hyunki Koo <kkoos00@naver.com>
> Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
> Cc: Shinbeom Choi <sbeom.choi@samsung.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
(also if combined with next one)

Best regards,
Krzysztof

