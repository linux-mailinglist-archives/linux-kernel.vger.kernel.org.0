Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6885412D53C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 01:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfLaA0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 19:26:23 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45616 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfLaA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:26:23 -0500
Received: by mail-ot1-f49.google.com with SMTP id 59so48303954otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tY8Yrw8DIjJkDyO6sYUuU7SfuMklcdzGkff08hmE4Ao=;
        b=dgIoT0J42Ou7CHq8ICw+sB1EJ0GvPVzM/1LtOcfGmbiYc7gi2/anT3BpZYQvUTFoGu
         /iUEqFHSP7CUp0DxHeEFkTr3/RuRSenVe3vuH7sg8Uil71DzcMU/mYYx4tmF5zTK3Izz
         TVxYsN7VzAnkJfMLfzzJscJ6owOm7SJevg5dKiTOKnKLp0PLAh0kuy/xVFnpSanC+QDA
         kM6b6po7oo9E+WUHkZsQFg5tJNg9XsiIWpM3tN3YWO+m1xviudu5d7bmIwv/qd+ddrj6
         DaH1hCZZJA2Lb/1oOk84R/kTIIjNW+MW7BPGuM6MyPYNhl64nEJvtDWFN5h+r+kqG7BA
         1NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tY8Yrw8DIjJkDyO6sYUuU7SfuMklcdzGkff08hmE4Ao=;
        b=o+kPZejE4GZ/Ub4TpflnGtZKG0cmRp1MygldJJL3vON8BJueiDo8eEfor7fwOqZSgf
         NW/OibMeM8tdiA7Aui+i9Kh+kRwihrrg+ml4x3T0cLFaSDZxPBXYecQMMZJfFAVCyDbT
         klWNGyGvcHxkTT4seoLKMk2IVrOInBEndxAGI2Iu87AMbw1tw8+GA2QYNzFGYHK7/Dwd
         Zwqa5qZeeMYzc9Y0LAS1Wn1Td/bFZ3V74NjdtOX/dz6sW9QajlbK/Nf5ktHzv6aNWKHd
         cyztYQxNUlCmCAexEF6memvj+967Oycy+8mD7WiVD5n9JK4H4A6lrVQfHHTEGp1eSCnI
         kiJg==
X-Gm-Message-State: APjAAAVUHKdqYq9ABVKzls/M01NjSdHsKxFAEezVl0C8IbuMYKwk2+Oy
        9Uyx0RNOgpvE4RxrYKAQe2tl8+QQOd4=
X-Google-Smtp-Source: APXvYqy9LfAQrOgHl5HalyErom/kVuj4JuD9Fyfi8LQik12tw0zIu6+2vXHMVCgu+FJSxZnPEsNGWw==
X-Received: by 2002:a9d:67ce:: with SMTP id c14mr51731605otn.106.1577751982462;
        Mon, 30 Dec 2019 16:26:22 -0800 (PST)
Received: from ?IPv6:2607:fb90:d7a:dfab:6680:99ff:fe6f:cb54? ([2607:fb90:d7a:dfab:6680:99ff:fe6f:cb54])
        by smtp.googlemail.com with ESMTPSA id 6sm9101246oil.43.2019.12.30.16.26.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 16:26:22 -0800 (PST)
To:     linux-kernel@vger.kernel.org
From:   Rob Landley <rob@landley.net>
Subject: Why is CONFIG_VT forced on?
Message-ID: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
Date:   Mon, 30 Dec 2019 18:30:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86-64 menuconfig, CONFIG_VT is forced on (in drivers->char devices->virtual
terminal), but the help doesn't mention a "selects", and I didn't spot anything
obvious in "find . -name 'Kconfig*' | xargs grep -rw VT".

Congratulations, you've reinvented "come from". I'm mostly familiar with the
kconfig plumbing from _before_ you made it turing complete: how do I navigate this?

I'm guessing "stick printfs into the menuconfig binary" is the recommended next
step for investigating this? Or is there a trick I'm missing?

Rob
