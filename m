Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888C517AD87
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 18:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgCERuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 12:50:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35524 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgCERuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:50:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so2950712plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=rC5OtK13XnzKjVKRv/ahMfo1lY7wZkZ7yJrsj3kp0MA=;
        b=NylefYR1wLE1MebQawnzVM1OzyZKJff36rYhBnH7mzz9fCJ7h6T1d3sDEceneTttms
         Pzx0tWoiknsjxQlYdzKMQmqsS5C7jlBaBCOOP9JXJKR4yYmCgQAprYQy7XL4Llcv8xbw
         5qD42gQpxnJ6Y01n/OWA0TIzMzWQpd93JOp88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=rC5OtK13XnzKjVKRv/ahMfo1lY7wZkZ7yJrsj3kp0MA=;
        b=plg7kXnspD4POnqHE0tvlxGcZbkc5Jf+Mgb68skTxzwfK4o6Sb0GoT02KXXViSkqtu
         n4z9YMPKq4FgFEhIuTlZxlD6wdV3WlU8VGiLxkeShUCCjj92sHzEmJ/c6JjvI5fSVGy1
         xjtcMPvka9MIq7ghUfcg+k3LDyaaz3rsHcILGrIw4oAMZQkbrViBqYWXcLUq/dEspZUd
         SHogudekBBQfoYkH+VHBcoUjUd35Xiw8QnESMrJc00QlW3Te1+3Es4IGia5Hl89rPSa6
         BmD817GXlNsmW/YxVryNlIAveaIQMXMhrx9ykUadIP6U/vpFLpGXkqPVri6mGAC7vLy5
         sKTA==
X-Gm-Message-State: ANhLgQ0COOLFOjr+9k65pXpBXmvOWkt+qK7/XziVC1VLQR9cbH+FVCXG
        v+Gh0grtVUMntzfo44RTIkC/PnCamuI=
X-Google-Smtp-Source: ADFU+vsmPBLgRU3w1Cl9Hu6agTsF4GwojuoHnJV+0HRo3jlsnoLAxcCl3AKFvsgw+z3bh5Am6N3g+w==
X-Received: by 2002:a17:90a:9409:: with SMTP id r9mr9847148pjo.39.1583430610997;
        Thu, 05 Mar 2020 09:50:10 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w76sm15012773pfc.154.2020.03.05.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:50:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583428023-19559-1-git-send-email-mkshah@codeaurora.org>
References: <1583428023-19559-1-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v12 0/4] Invoke rpmh_flush for non OSI targets
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Thu, 05 Mar 2020 09:50:09 -0800
Message-ID: <158343060946.7173.9822192224809476773@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-03-05 09:06:59)
> Changes in v12:
> - Kconfig change to remove COMPILE_TEST was dropped in v11, reinclude it.

What is the difficulty in maintaining COMPILE_TEST support? If it's
purely making a stub function for OSI support then I'm lost why we can't
have another patch at the start of the series that makes the function
return false when PSCI is disabled.
