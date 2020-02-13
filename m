Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8C15C296
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgBMPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 10:35:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46949 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388085AbgBMPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:31:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so7179655wrl.13;
        Thu, 13 Feb 2020 07:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jY+YnMofuqwzjILofdtROeXpT9sto3UqcBNW/xLjoRs=;
        b=pMu8qWisYyaMHM2tnHMktgLsO04+nQvZ6zDXoYNfcRi1UXplaz/1HVsQS/Ea4ZnRIy
         Y4EfxaXb9c3cxF8rXOM0BjWn7zYUNOvVsuZ1EEgXknU9BbKCt2yic2hQLu+uvGbfaDIq
         bOras25oV+gjPZm0Xah6RXvFKK3pkzhRb0DED4iFXQwklCkfNacH1kkE2PKCrR8vrUhT
         xcIqw5XUOdNKIQZmWV1a5q0Y9cEurSyc5lJ784goDVfUs7oorbiios0LjGZWKAbx892A
         GAheOuDXqapKdiCKErkXodg6gpZ32V247Z6cdiWlztK0pyW9Vsu6PzDNyqFJw341KkkK
         AXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jY+YnMofuqwzjILofdtROeXpT9sto3UqcBNW/xLjoRs=;
        b=olo6MZ1+5niy0iyHC+fjvzYxfYRDF+ySnlEfWyTZy4LWhhPPFZgXmjU41wZLuqjRCd
         WxcgfcDD3quk2VEGfmK0TG9tfWGdqIxcx/cXaLrVKuvIbz/Q1wxAuIDLQyQ/eYexncH+
         HRBa8OGfPvVBFCWCVaWdSSjim//6uYjonQJfA7cbJ9cjq/JfVckkGmGWNe9n1IT+P7D9
         wFNQUf3iZ+hhENfBeDJf+3Y1Iygk1GL4erw2k2xBg1fk3bR5sSzSwTll1GcY/JnSTXve
         bOhSc6SA/jWz5VEqiQC0yiYZqIDa0u19+2MbT4BRxty8pJ5Cs1dihjs3vxIQaA+dMpxV
         HAdA==
X-Gm-Message-State: APjAAAU4i9ADgdovXWEXqFJL8+ZvcpUqYo8vokFcEeXQsaR0ffjV+EmR
        PqUO2ogFcv/5NSUOuZU4deo=
X-Google-Smtp-Source: APXvYqw7slUsjNQkyU+rvi+PmJErVCo36nL+8e2UFRgWoCo3D5Shs+6iWOnwkAagzlIj1g9ifPTGCA==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr23122503wrs.143.1581607913331;
        Thu, 13 Feb 2020 07:31:53 -0800 (PST)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id q14sm3278650wrj.81.2020.02.13.07.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 07:31:52 -0800 (PST)
Date:   Thu, 13 Feb 2020 16:31:51 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     festevam@gmail.com, Anson.Huang@nxp.com
Cc:     Aisheng Dong <aisheng.dong@nxp.com>, leonard.crestez@nxp.com,
        peng.fan@nxp.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: clk: imx: clock driver for imx8qm?
Message-ID: <20200213153151.GB6975@optiplex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Favio,
Hello Anson,

is someone working on clock driver for imx8qm? I miss at least a
clk-imx8qm.c in the drivers/imx/clk/ directory. I saw that you are
working in this area and perhaps you can give me some insights what is
needed here.

Best regards,

Oliver
