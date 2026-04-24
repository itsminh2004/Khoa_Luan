package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.Policy;
import khoaluantotnghiep.service.IPolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller(value = "policyControllerOfAdmin")
public class PolicyController {

    @Autowired
    private IPolicyService policyService;

    @RequestMapping(value = "/admin-policy-list", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView mav = new ModelAndView("admin/policy/list");
        mav.addObject("policies", policyService.findAll());
        return mav;
    }

    @RequestMapping(value = "/admin-policy-edit", method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id", required = false) Integer id) {
        ModelAndView mav = new ModelAndView("admin/policy/edit");
        if (id != null) {
            mav.addObject("policy", policyService.findOne(id));
        } else {
            mav.addObject("policy", new Policy());
        }
        return mav;
    }

    @RequestMapping(value = "/admin-policy-edit", method = RequestMethod.POST)
    public String save(@org.springframework.web.bind.annotation.ModelAttribute("policy") Policy policy) {
        policyService.save(policy);
        return "redirect:/admin-policy-list";
    }
    @RequestMapping (value = "/admin-policy-delete/{id}", method= RequestMethod.GET )
    public String delete(@PathVariable("id") int id) {
        policyService.delete(id);
        return "redirect:/admin-policy-list";
    }
}
