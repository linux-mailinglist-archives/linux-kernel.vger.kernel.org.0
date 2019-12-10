Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC507118C21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 16:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLJPLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 10:11:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42377 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:11:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so16247552edv.9;
        Tue, 10 Dec 2019 07:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5IcAHdSxCVaQr71MDw/u4OSVbxGZ7HWDDux3wC+gVQ=;
        b=qdA9GFosMcL8jVZusvCRyXhXejxqshpWIwt8LMMrH24Mf+cSy1g8p73QHvC33XrRWp
         DqWq5LUQIi4wPSsyJYYnHT7ZmvQxqcLf/ozh8itv2cbliw/i1PSoFatBn7mftBH++mZt
         bhurOrhe2EQ0SKokaTvai6qX09rv0kFPF0xecIFz7oStCazIbSnY5TpzObi07CAWNSrM
         ZW2raEf2tE5sMTFxAKh2ecneNv+PBCJpSCh4uhvOKh9yF0SA7hODjmnagpJa2zqZEyVs
         DnprZJ9FQK8vt+zfTaquM1/WWk9KaUvK0LqqI5BSZdkyT0YZRSKQK+bqU2ie/BZumy+1
         WtSQ==
X-Gm-Message-State: APjAAAWoV8H8eJNJZgeHAr57HbIP0SfiXk9+XUWhEDp2iBR+2IbZNYbQ
        upZX3g/9PAMO383/t8p7194=
X-Google-Smtp-Source: APXvYqw5jbPq4FswRVWVBj9g7UTnNhv9eRpXy/D1mfxGrUvwdSteqcL3i+CjwMzPw/KYvZxjGO+jRQ==
X-Received: by 2002:a05:6402:305b:: with SMTP id bu27mr39330099edb.191.1575990660199;
        Tue, 10 Dec 2019 07:11:00 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id ck28sm85351edb.45.2019.12.10.07.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:10:59 -0800 (PST)
Date:   Tue, 10 Dec 2019 16:10:57 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] tty: serial: samsung_tty: use 'unsigned int' not
 'unsigned'
Message-ID: <20191210151057.GG11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-8-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-8-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 03:37:04PM +0100, Greg Kroah-Hartman wrote:
> The function uart_console_write() expects an unsigned int, so use that
> variable type, not 'unsigned', which is generally frowned apon in the
> kernel now.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

