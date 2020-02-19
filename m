Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEE1652C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 23:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBSWyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 17:54:52 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35995 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSWyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:54:51 -0500
Received: by mail-pj1-f65.google.com with SMTP id gv17so11690pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=gAAaumqYIWK1r6Wc40UnUA72PdD5YfOwATHdty8pLNM=;
        b=U9ssDP3iopMhkc0fGFmgcEWKMR9NdKLFDjPfwOkpPj0ihd1gTFbc5C5gYcL8RW7Hbf
         cOp+Mst4AdL8f/RZ0MMMbOtddAbK0VaZORxXpV0KWQuuCzuXeZNj0ELdVJrKzaZxpIyl
         OXvwQNltns5cUUXX0UtkBexfx+pbD8Jquo9uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=gAAaumqYIWK1r6Wc40UnUA72PdD5YfOwATHdty8pLNM=;
        b=RlMGjGqJT5F9zJzqGYkRKBNjLQJHDpklvuDOnWr+lzkVNZv7vUnJmcLRx1h3vu1t7i
         +GPEBBM3HtX/yuFhUy+A8UNRUp4Sv5ZrywhXAtNh956KpLHFgMmKJ78mQqHtwX/jy+LE
         JheWIfjqqCCykNp/35gQDbewebINqHqAJrov1uME08SsuEuEEcYaicoCpkxX0Q7ItYPm
         soANkQLD/YpOCJiert/0vMqZxWjBrnoTxQt+K2AolmJPG46ynhBZ95FKQab2Wk2m65g5
         OR8Rd3k/faIb4xjVthnzRgKhrEx1dNQZb/gTtLBcdamWIDg2UCO3PJBgKOoA9ACdvG3t
         87uQ==
X-Gm-Message-State: APjAAAUnEf8aqYAhgKYHJx6grM/aPCOVMLHs3L+paqJqPgzKnROK0OyX
        hRl5vrraVUsyA0RS4MoaoNm3XA==
X-Google-Smtp-Source: APXvYqzSKpdk8pkApBBqNrjyPAGxS77LNhITRpxYsSt0GkVb7Mrna64ELgb03Juesjnyn8Gj6rVD3Q==
X-Received: by 2002:a17:902:7b94:: with SMTP id w20mr28153885pll.257.1582152891216;
        Wed, 19 Feb 2020 14:54:51 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r11sm778107pgi.9.2020.02.19.14.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:54:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <57f5fd302213d30b53d9d6b3624758180e8df48b.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <57f5fd302213d30b53d9d6b3624758180e8df48b.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 2/8] drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:54:50 -0800
Message-ID: <158215289002.184098.18143863253451092907@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:06)
> All the sensor data is initialised at init time. Lock it down by passing
> it to functions as a constant.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
