Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5613F21B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 19:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbgAPSdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 13:33:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32952 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390720AbgAPRYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so23613986lji.0;
        Thu, 16 Jan 2020 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qBjobR/3CL6r8XuRji53OarjX1+elaLjxcdkqSb5aBQ=;
        b=tsUZtlDy8N8TE+XBhcYSrIrlCA6GjHuqpW8cKg4khiKwHyVfzYessSiDHwsv3Jwh2q
         D0J3pw6Q6KFMp8kdZrpUW1oGekA2d4x+/uiXwKkdPNNsu8twVC0se3/VLwBP9bSDH1a7
         yuE3qL11sfjxBlDHvA+SRGrS/XeuknjfxdeD7B62lcRwKEcNWj1SdRvftz6vOjm3RyeB
         FGNGvjM5DTSU0+ybwvmdt7Qw/QRnQbxAXECpkF3WhS5UIp+Di/9qh8Yk9gTn9SWjJxxG
         kGy0Xn19B64j8OdXiqM5Fp42QEU/VRlEUKgxp1VCpcEbsvM8uRGV7S/H32VYbDWUgdXH
         +IoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qBjobR/3CL6r8XuRji53OarjX1+elaLjxcdkqSb5aBQ=;
        b=nOb/cJV7rGPVqcaW37dLvBAyEPG1PnbWPrCWCVobfmEjndYqAdmakscBEc3le0Y1UQ
         gyI+WyOLT87mte7H6QGUFYryuVV2tFnLzDsZCjwnd8NV0LjjyfnRnY6D6BqGCzEAfapf
         YG+eY7cpNytqvVHaQknSygEFmKKyyqD5EwVam6oQ6FSylp3Hd5s0rbOD0vliKuh1Ouyo
         MKQa4ynvKbC4GGgDUW0QKA+71OJwJ7vsFmpape8jhss5UzeGdWaOFF7zpr9XVbTG4J8R
         HBL+SIXrg914SI3/E7XyJY+XAaP6wpUGldu1e5tHNhGjOSe5m5KWqpF/bSzDACXBfWDj
         YDqw==
X-Gm-Message-State: APjAAAXQJH8fVJqKVbKJ+/g51/+Pfr/jdDHejtysic1btVtRlB1BMnIA
        KQuK9nlcNb+Khn20Cp8BBmw=
X-Google-Smtp-Source: APXvYqx5BbRkPGf0Rmmj3K22tePVgNk2FDz+rHvztncxEyPe5Ag0gETeyhiYa9uA+YtEQr+BQVjlXA==
X-Received: by 2002:a2e:7c08:: with SMTP id x8mr3088472ljc.185.1579195492554;
        Thu, 16 Jan 2020 09:24:52 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id s1sm11154402ljc.3.2020.01.16.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 09:24:51 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Jan 2020 18:24:44 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200116172444.GA23524@pc636>
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200116011410.GC246464@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116011410.GC246464@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
Thank you and appreciate your help, Joel.

>
> (Vlad is going to post a v2 which fixes a debugobjects bug but that should
> not have any impact on testing).
> 
I will do that :)

--
Vlad Rezki
