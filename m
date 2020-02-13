Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E429F15CC51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 21:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgBMUX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 15:23:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36405 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgBMUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:23:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so8207495wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z0gjJEmRAwNymPwA00fmzFhjNC7Qe4kL5vReX8cevnI=;
        b=Hz/xL3g4x51bG7UTsON1g0txoL+UQIUGlDIxuBxUvr2H3k12pXc/T/otefb4iCRVft
         4ov86aKFTIW1nMR+qgtLawZAt6+nyiYLHH4OCVRSmd1Fh3PaOR9aMQ/e5M/sPXu7owO4
         jOS7Po0sT9ic7cUHflzW8HE8OycaB9fYChOyRnCocqK6mu1rT/gnzpro/8OZSG+Ay0kk
         C+ANlMSCQ/oPcITNh6DtEDm5Mr/DpbgwrsDe8A3Vo0JQot/cuxDnVwJ6MIYADFOig9Aq
         xt6hnnucC1kJVZpl7n7GqLBnFfhymOeWIUp+ApzWYNs0sqVarGSIZ/fw/Nb3LhVBOYeF
         y/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z0gjJEmRAwNymPwA00fmzFhjNC7Qe4kL5vReX8cevnI=;
        b=SDDXdKEn7aEMrkaxG3zhVsBy/MgDt9xK5iFNrlL/5I76utPp8d+c2lrnot5pHWU3L5
         kPyVeX68uU0Bku5Mf2GbSMmGIBAcEIhdhdTHtk9UoJJhKeZWawyic6afuP/WTdIWEc95
         TGGNL2Xc2OTImPrBc+ncXUiDHENxDSC1sWjfESTwpBN3dz8m91P2BIxsHitjifsVWGKb
         9g9ov8ZWmucsNE0akMbSNPY2MMkUya32jtTVSvW2vIHUOEk9qoS8K0t2WdUchICkl3cg
         eJJBPVtucisqH1Wusc+3i+der9lF0HbYHyexukAsKkrpAxhL2bQhcbkCPdmvkZ6EkDrK
         4rOw==
X-Gm-Message-State: APjAAAWRi1CBoARJjcGpAMLvPIA8iuOYSpTncM+XIGUNwVP93crTuCh2
        o5FvuDJe/j6BneaQ5VWz7AuZaA==
X-Google-Smtp-Source: APXvYqzqyPeBFBhVewwKaBK9XjxIwvnsPNpsAByNUUEuukhTDypWS6UDuisfdJZDF6q4I4Mj1hC2NA==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr7779715wme.183.1581625434916;
        Thu, 13 Feb 2020 12:23:54 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o15sm4276160wra.83.2020.02.13.12.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 12:23:54 -0800 (PST)
Subject: Re: [PATCH 1/2] watchdog: Check WDOG_STOP_ON_REBOOT in reboot
 notifier
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
References: <20200213175958.105914-1-dima@arista.com>
 <20200213175958.105914-2-dima@arista.com>
 <20200213191230.GA17448@roeck-us.net>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <3de88f30-e601-77b3-d477-ca9ce461c920@arista.com>
Date:   Thu, 13 Feb 2020 20:23:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200213191230.GA17448@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 2/13/20 7:12 PM, Guenter Roeck wrote:
> Does that really have to be decided at runtime, by the user ?
> How about doing it with a module parameter ?
> 
> Also, I am not sure if an ioctl is the best means to do this, if it indeed
> makes sense to decide it at runtime. ioctl implies an open watchdog device,
> which interferes with the watchdog daemon. This means that the watchdog
> daemon would have to be modified to support this, making this a quite expensive
> change. It also implies that the action would have to be known when the
> watchdog daemon is started, suggesting that a module parameter should be
> sufficient.

Yes, fair points. I went with ioctl() because the timeout can be changed
in runtime. But you're right, I'll look into making it a module
parameter instead.

Thanks for the review and time,
          Dmitry
