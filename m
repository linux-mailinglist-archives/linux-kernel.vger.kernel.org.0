Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53EAB8649
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 00:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407309AbfISW2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 18:28:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393322AbfISW2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:28:12 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8JMMLNq091634;
        Thu, 19 Sep 2019 18:27:55 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v4g2u4pxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 18:27:55 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8JMJZti025591;
        Thu, 19 Sep 2019 22:27:55 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 2v3vc5h0qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 22:27:55 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8JMRsOQ51315116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 22:27:54 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB13AE05F;
        Thu, 19 Sep 2019 22:27:54 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A45D0AE05C;
        Thu, 19 Sep 2019 22:27:53 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.81])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 19 Sep 2019 22:27:53 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/1] powerpc: kvm: Reduce calls to get current->mm by storing the value locally
Date:   Thu, 19 Sep 2019 19:27:48 -0300
Message-Id: <20190919222748.20761-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=420 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduces the number of calls to get_current() in order to get the value of
current->mm by doing it once and storing the value, since it is not
supposed to change inside the same process).

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 9a75f0e1933b..f2b9aea43216 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -508,6 +508,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	struct vm_area_struct *vma;
 	unsigned long rcbits;
 	long mmio_update;
+	struct mm_struct *mm;
 
 	if (kvm_is_radix(kvm))
 		return kvmppc_book3s_radix_page_fault(run, vcpu, ea, dsisr);
@@ -584,6 +585,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	is_ci = false;
 	pfn = 0;
 	page = NULL;
+	mm = current->mm;
 	pte_size = PAGE_SIZE;
 	writing = (dsisr & DSISR_ISSTORE) != 0;
 	/* If writing != 0, then the HPTE must allow writing, if we get here */
@@ -592,8 +594,8 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	npages = get_user_pages_fast(hva, 1, writing ? FOLL_WRITE : 0, pages);
 	if (npages < 1) {
 		/* Check if it's an I/O mapping */
-		down_read(&current->mm->mmap_sem);
-		vma = find_vma(current->mm, hva);
+		down_read(&mm->mmap_sem);
+		vma = find_vma(mm, hva);
 		if (vma && vma->vm_start <= hva && hva + psize <= vma->vm_end &&
 		    (vma->vm_flags & VM_PFNMAP)) {
 			pfn = vma->vm_pgoff +
@@ -602,7 +604,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			is_ci = pte_ci(__pte((pgprot_val(vma->vm_page_prot))));
 			write_ok = vma->vm_flags & VM_WRITE;
 		}
-		up_read(&current->mm->mmap_sem);
+		up_read(&mm->mmap_sem);
 		if (!pfn)
 			goto out_put;
 	} else {
@@ -621,8 +623,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			 * hugepage split and collapse.
 			 */
 			local_irq_save(flags);
-			ptep = find_current_mm_pte(current->mm->pgd,
-						   hva, NULL, NULL);
+			ptep = find_current_mm_pte(mm->pgd, hva, NULL, NULL);
 			if (ptep) {
 				pte = kvmppc_read_update_linux_pte(ptep, 1);
 				if (__pte_write(pte))
-- 
2.20.1

